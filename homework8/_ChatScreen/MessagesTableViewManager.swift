//
//  MessagesTableViewManager.swift
//  homework8
//
//  Created by Christina Kang on 11/14/24.
//

import Foundation
import UIKit

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
        cell.wrapperCellView.backgroundColor = userMessage ? UIColor.systemBlue.withAlphaComponent(0.4) : UIColor.lightGray.withAlphaComponent(0.3)
        
        cell.labelName.text = message.name
        cell.labelText.text = message.text
        cell.labelDateAndTime.text = message.dateAndTime
        
        return cell
    }
    
}
