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
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func observeChats() {
        guard let userUid = currentUser?.uid else {
            print("Current user UID is nil.")
            return
        }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MM/dd/yy, HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM/dd/yy, hh:mm a"

        database.collection("users")
            .document(userUid)
            .collection("chats")
            .addSnapshotListener(includeMetadataChanges: false) { [weak self] querySnapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                self.chatList.removeAll()
                for document in querySnapshot!.documents {
                    if let chatId = document.data()["chatId"] as? String,
                       let uid = document.data()["uid"] as? String,
                       let name = document.data()["name"] as? String {
                        print(chatId)
                        self.fetchLastMessage(chatId: chatId, uid: uid, name: name)
                    }
                }
                DispatchQueue.main.async {
                    self.chatList.sort(by: { $0.dateAndTime > $1.dateAndTime })
                    for index in 0..<self.chatList.count {
                        if let date = inputFormatter.date(from: self.chatList[index].dateAndTime) {
                            self.chatList[index].dateAndTime = outputFormatter.string(from: date)
                        }
                    }
                    self.chatListScreen.tableViewChats.reloadData()
                }
            }
    }
    
    func fetchLastMessage(chatId: String, uid: String, name: String) {
        database.collection("chats")
            .document(chatId)
            .collection("messages")
            .order(by: "dateAndTime", descending: true)
            .limit(to: 1)
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error getting last message: \(error)")
                    return
                }
                guard let document = querySnapshot?.documents.first else {
                    print("No messages found.")
                    return
                }
                do {
                    var lastMessage = try document.data(as: Message.self)
                    // Update the message with the chat's uid and name
                    lastMessage.uid = uid
                    lastMessage.name = name
                    self.chatList.append(lastMessage)
                    DispatchQueue.main.async {
                        self.chatListScreen.tableViewChats.reloadData()
                    }
                } catch {
                    print("Error decoding message: \(error)")
                }
            }
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
