//
//  ChatsTableViewManager.swift
//  homework8
//
//  Created by Charles Yang on 11/13/24.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatsTableViewCell
        cell.labelName.text = chatList[indexPath.row].name
        cell.labelText.text = chatList[indexPath.row].text
        cell.labelTime.text = chatList[indexPath.row].dateAndTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // select the user to send messages to
        tableView.deselectRow(at: indexPath, animated: true)
        // let recipient = chatList[indexPath.row]
        
        let recipient = User(name: chatList[indexPath.row].name,email: nil, uid: chatList[indexPath.row].uid)
        
        let chatController = ChatScreenViewController()
        chatController.recipient = recipient
        navigationController?.pushViewController(chatController, animated: true)
    }
}
