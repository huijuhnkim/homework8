//
//  UserTableViewManager.swift
//  homework8
//
//  Created by Charles Yang on 11/14/24.
//

import Foundation
import UIKit

extension AddChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatsTableViewCell
        cell.labelName.text = userList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // select the user to send messages to
        tableView.deselectRow(at: indexPath, animated: true)
        let chatController = ChatScreenViewController()
        
        guard let currentUserUid = currentUser?.uid, let currentUserName = currentUser?.displayName else {
            return
        }

        let recipient = userList[indexPath.row]
        let currentChatID = [currentUserUid, recipient.uid].sorted().joined()

        let recipientName = recipient.name
        let chatData = ["chatId": currentChatID, "name": recipientName, "uid": recipient.uid]
        let chatDataRecipient = ["chatId": currentChatID, "name": currentUserName, "uid": currentUserUid]

        let userChatRef = self.database.collection("users")
            .document(currentUserUid)
            .collection("chats")
            .document(recipientName)

        userChatRef.setData(chatData, merge: true) { error in
            if let error = error {
                print("Error adding/updating document: \(error)")
            } else {
                print("Chat data added/updated successfully")
            }
        }

        let recipientChatRef = self.database.collection("users")
            .document(recipient.uid)
            .collection("chats")
            .document(currentUserName)

        recipientChatRef.setData(chatDataRecipient, merge: true) { error in
            if let error = error {
                print("Error adding/updating document: \(error)")
            } else {
                print("Recipient chat data added/updated successfully")
                chatController.recipient = recipient
                self.navigationController?.pushViewController(chatController, animated: true)
            }
        }
    }
    
    
}
