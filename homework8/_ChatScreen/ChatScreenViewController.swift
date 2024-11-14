//
//  ChatScreenViewController.swift
//  homework8
//
//  Created by Christina Kang on 11/12/24.
//

import UIKit
import FirebaseAuth

class ChatScreenViewController: UIViewController {
    
    let chatScreen = ChatScreenView()
    
    var userMessages = [Message]()
    var currentUser:FirebaseAuth.User?
    
    override func loadView(){
        view = chatScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatScreen.tableViewMessages.dataSource = self
        chatScreen.tableViewMessages.delegate = self
        chatScreen.tableViewMessages.separatorStyle = .none
        
        
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

}
// need to implement scroll to bottom and displaying time and date**
extension ChatScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // checks if message is user's message
        // sets user's message to light blue and friend's to light gray
        let message = userMessages[indexPath.row]
        let userMessage = message.name == currentUser?.displayName
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messages", for: indexPath) as! MessagesTableViewCell
        cell.contentView.backgroundColor = userMessage ? UIColor.systemBlue.withAlphaComponent(0.3) : UIColor.lightGray.withAlphaComponent(0.3)
        cell.labelText.text = message.text
        
        return cell
    }
    
}
