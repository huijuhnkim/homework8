//
//  ViewController.swift
//  homework8
//
//  Created by Hui Juhn Kim on 11/11/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let chatListScreen = ChatListView()
    
    var chatList = [Message]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = chatListScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }

            if user == nil {
                self.currentUser = nil
                self.chatListScreen.labelText.text = "Please sign in to see the chats!"
                self.chatListScreen.floatingButtonAddChat.isEnabled = false
                self.chatListScreen.floatingButtonAddChat.isHidden = true

                self.chatList.removeAll()
                self.chatListScreen.tableViewChats.reloadData()

                self.setupLeftBarButton(isLoggedin: false)
                
                DispatchQueue.main.async {
                    self.showLoginViewController()
                }
            } else {
                self.currentUser = user
                self.chatListScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.chatListScreen.floatingButtonAddChat.isEnabled = true
                self.chatListScreen.floatingButtonAddChat.isHidden = false

                self.setupLeftBarButton(isLoggedin: true)
                self.observeChats()
            }
        }
        
        title = "Chats"
        
        //MARK: patching table view delegate and data source...
        chatListScreen.tableViewChats.delegate = self
        chatListScreen.tableViewChats.dataSource = self
        
        //MARK: removing the separator line...
        chatListScreen.tableViewChats.separatorStyle = .none
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        view.bringSubviewToFront(chatListScreen.floatingButtonAddChat)
        
        //MARK: tapping the floating add Chat button...
        chatListScreen.floatingButtonAddChat.addTarget(self, action: #selector(addChatButtonTapped), for: .touchUpInside)
    }
    
    func showLoginViewController() {
        //        let addChatController = AddChatViewController()
        //        addChatController.currentUser = self.currentUser
        //
        //        print("start new chat")
        //
        //        navigationController?.pushViewController(addChatController, animated: true)
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func observeChats() {
        database.collection("users")
            .document((currentUser?.email)!)
            .collection("chats")
            .addSnapshotListener(includeMetadataChanges: false, listener: { [weak self] querySnapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                self.chatList.removeAll()
                for document in querySnapshot!.documents {
                    do {
                        let chat = try document.data(as: Message.self)
                        self.chatList.append(chat)
                    } catch {
                        print("Error decoding user: \(error)")
                    }
                }
                self.chatList.sort(by: {$0.dateAndTime < $1.dateAndTime})
                self.chatListScreen.tableViewChats.reloadData()
            })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    @objc func addChatButtonTapped(){
        let addChatController = AddChatViewController()
        addChatController.currentUser = self.currentUser

        print("start new chat")

        navigationController?.pushViewController(addChatController, animated: true)
    }
}

