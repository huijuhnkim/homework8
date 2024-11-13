//
//  ChatListView.swift
//  homework8
//
//  Created by Hui Juhn Kim on 11/12/24.
//

import UIKit

class ChatListView: UIView {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setup()
        initConstraints()
    }
    
    func setup() {
        label = UILabel()
        label.text = "Chat List"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
