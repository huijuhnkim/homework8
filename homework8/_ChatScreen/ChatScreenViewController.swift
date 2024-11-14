//
//  ChatScreenViewController.swift
//  homework8
//
//  Created by Christina Kang on 11/12/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatScreenViewController: UIViewController {
    
    let chatScreen = ChatScreenView()
    
    var userMessages = [Message]()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    var recipientName: String?
    var chatID: String?
    
    override func loadView(){
        view = chatScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatScreen.tableViewMessages.dataSource = self
        chatScreen.tableViewMessages.delegate = self
        chatScreen.tableViewMessages.separatorStyle = .none
        
        // create chat ID
        createChatID()
        
        // get all messages
        getMessages()
        
        // send button action
        chatScreen.buttonSend.addTarget(self, action: #selector(onSendButtonTapped), for: .touchUpInside)
        
        // press "My Chats" button on top left to go back to chat list
        let backButton = UIBarButtonItem(
            title: "My Chats",
            style: .plain,
            target: self,
            action: #selector(onBackButtonTapped))
        
        self.navigationItem.backBarButtonItem = backButton
       
    }
    
    @objc func onBackButtonTapped(){
        let chatListScreen = ChatListViewController()
        navigationController?.pushViewController(chatListScreen, animated: true)
    }
    
    // create chat ID by combining sender's and recipient's name
    func createChatID(){
        guard let currentUserName = currentUser?.displayName, let recipientName = recipientName else {
            return
        }
        
        let currentChatID = currentUserName + recipientName
        
        chatID = currentChatID
    
    }
    
    func getMessages(){
        // date and time formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        guard let chatID = chatID else {
            return
        }
        
        self.database.collection("users")
            .document((self.currentUser?.email)!)
            .collection("chats")
            .document(chatID)
            .collection("messages")
            .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.userMessages = documents.map { document in
                        let data = document.data()
                        let name = data["name"] as? String ?? ""
                        let text = data["text"] as? String ?? ""
                        let timestamp = (data["dateAndTime"] as? Timestamp)?.dateValue() ?? Date()
                        let dateAndTime = dateFormatter.string(from: timestamp)
                                  
                        return Message(name: name, text: text, dateAndTime: dateAndTime)
                    }
                    self.chatScreen.tableViewMessages.reloadData()
                    self.scrollToBottom()
                }
            })
    }
    
    @objc func onSendButtonTapped(){
        guard let chatID = chatID else {return}
        guard let text = chatScreen.textFieldMessage.text else { return  }
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let dateAndTime = dateFormatter.string(from: Date())
        
        // get current user's name
        let senderName = currentUser?.displayName ?? "No Name"
        
        // create message object with sender's name, text and date and time
        let message = Message(name: senderName, text: text, dateAndTime: dateAndTime)
        
        // add to messages collection
        let collectionMessages =
        self.database.collection("users")
            .document((self.currentUser?.email)!)
            .collection("chats")
            .document(chatID)
            .collection("messages")
        
        do{
            try collectionMessages.addDocument(from: message, completion: {(error) in
                if error == nil{
                    self.scrollToBottom()
                }
            })
        }
        catch {
            print("Error sending message!")
        }
    }
    
    // scroll to bottom of the chat
    func scrollToBottom(){
        if userMessages.count > 0 {
            let lastMessageRowIndex = IndexPath(row: userMessages.count - 1, section: 0)
            chatScreen.tableViewMessages.scrollToRow(at: lastMessageRowIndex, at: .bottom, animated: false )
        }
    }
                    
}