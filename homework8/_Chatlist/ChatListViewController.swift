
//
//  ChatListViewController.swift
//  homework8
//
//  Created by Charles Yang on 11/12/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatListViewController: UIViewController {
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
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.chatListScreen.labelText.text = "Please sign in to see the chats!"
                self.chatListScreen.floatingButtonAddChat.isEnabled = false
                self.chatListScreen.floatingButtonAddChat.isHidden = true
                
                //MARK: Reset tableView...
                self.chatList.removeAll()
                self.chatListScreen.tableViewChats.reloadData()
                
                //MARK: Sign in bar button...
                self.setupLeftBarButton(isLoggedin: false)
                
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                self.chatListScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.chatListScreen.floatingButtonAddChat.isEnabled = true
                self.chatListScreen.floatingButtonAddChat.isHidden = false
                
                //MARK: Logout bar button...
                self.setupLeftBarButton(isLoggedin: true)
                
                //MARK: Observe Firestore database to display the Chats list...
                self.database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("chats")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.chatList.removeAll()
                            for document in documents{
                                do{
                                    let chat  = try document.data(as: Message.self)
                                    self.chatList.append(chat)
                                }catch{
                                    print(error)
                                }
                            }
                            self.chatList.sort(by: {$0.dateAndTime < $1.dateAndTime})
                            self.chatListScreen.tableViewChats.reloadData()
                        }
                    })
                
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
