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
        let recipientName = userList[indexPath.row].name
        
        let chatController = ChatScreenViewController()
        chatController.recipientName = recipientName
        navigationController?.pushViewController(chatController, animated: true)
    }
    
    
}
