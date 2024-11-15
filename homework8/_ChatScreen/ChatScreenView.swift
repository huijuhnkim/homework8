//
//  ChatScreenView.swift
//  homework8
//
//  Created by Christina Kang on 11/12/24.
//

import UIKit

class ChatScreenView: UIView {

    var labelRecipientName: UILabel!
    var tableViewMessages: UITableView!
    var bottomAddView: UIView!
    var textFieldMessage: UITextField!
    var buttonSend: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelRecipientName()
        setupTableViewMessages()
        setupBottomAddView()
        setupTextFieldMessage()
        setupButtonSend()
        
        initConstraints()
    }
    
    func setupLabelRecipientName(){
        labelRecipientName = UILabel()
        labelRecipientName.textAlignment = .center
        labelRecipientName.font = UIFont.boldSystemFont(ofSize: 25)
        labelRecipientName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelRecipientName)
    }
    
    func setupTableViewMessages(){
        tableViewMessages = UITableView()
        tableViewMessages.register(MessagesTableViewCell.self, forCellReuseIdentifier: "messages")
        tableViewMessages.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewMessages)
    }
    
    func setupBottomAddView(){
        bottomAddView = UIView()
        bottomAddView.backgroundColor = .white
        bottomAddView.layer.cornerRadius = 6
        bottomAddView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomAddView.layer.shadowOffset = .zero
        bottomAddView.layer.shadowRadius = 4.0
        bottomAddView.layer.shadowOpacity = 0.6
        bottomAddView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomAddView)
    }
    
    func setupTextFieldMessage(){
        textFieldMessage = UITextField()
        textFieldMessage.placeholder = "Enter Message"
        textFieldMessage.borderStyle = .roundedRect
        textFieldMessage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldMessage)
    }
    
    func setupButtonSend(){
        buttonSend = UIButton(type: .system)
        buttonSend.setTitle("Send", for: .normal)
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSend)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelRecipientName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
            labelRecipientName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            labelRecipientName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            bottomAddView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bottomAddView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomAddView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            bottomAddView.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldMessage.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -10),
            textFieldMessage.leadingAnchor.constraint(equalTo: bottomAddView.leadingAnchor, constant: 16),
            textFieldMessage.widthAnchor.constraint(equalToConstant: 300),
            
            buttonSend.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -10),
            buttonSend.trailingAnchor.constraint(equalTo: bottomAddView.trailingAnchor, constant: -16),
            
            bottomAddView.topAnchor.constraint(equalTo: buttonSend.topAnchor, constant: -8),
            
            tableViewMessages.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            tableViewMessages.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewMessages.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewMessages.bottomAnchor.constraint(equalTo: bottomAddView.topAnchor, constant: -8),
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
