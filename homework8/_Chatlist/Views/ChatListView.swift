//
//  ChatListView.swift
//  homework8
//
//  Created by Charles Yang on 11/12/24.
//

import UIKit

class ChatListView: UIView {
    var labelText: UILabel!
    var floatingButtonAddChat: UIButton!
    var tableViewChats: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
        setupFloatingButtonAddChat()
        setupTableViewChats()
        initConstraints()
    }

    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupTableViewChats(){
        tableViewChats = UITableView()
        tableViewChats.register(ChatsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewChatsID)
        tableViewChats.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewChats)
    }
    
    func setupFloatingButtonAddChat(){
        floatingButtonAddChat = UIButton(type: .system)
        floatingButtonAddChat.setTitle("", for: .normal)
        floatingButtonAddChat.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        floatingButtonAddChat.contentHorizontalAlignment = .fill
        floatingButtonAddChat.contentVerticalAlignment = .fill
        floatingButtonAddChat.imageView?.contentMode = .scaleAspectFit
        floatingButtonAddChat.layer.cornerRadius = 16
        floatingButtonAddChat.imageView?.layer.shadowOffset = .zero
        floatingButtonAddChat.imageView?.layer.shadowRadius = 0.8
        floatingButtonAddChat.imageView?.layer.shadowOpacity = 0.7
        floatingButtonAddChat.imageView?.clipsToBounds = true
        floatingButtonAddChat.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAddChat)
    }
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            labelText.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            tableViewChats.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            tableViewChats.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewChats.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewChats.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            floatingButtonAddChat.widthAnchor.constraint(equalToConstant: 48),
            floatingButtonAddChat.heightAnchor.constraint(equalToConstant: 48),
            floatingButtonAddChat.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButtonAddChat.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
