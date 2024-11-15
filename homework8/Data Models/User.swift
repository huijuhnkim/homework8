//
//  User.swift
//  homework8
//
//  Created by Charles Yang on 11/14/24.
//

import Foundation

struct User: Codable{
    var name: String
    var email: String
    
    init(name: String, email: String){
        self.name = name
        self.email = email
    }
}

struct Users: Codable{
    let users: [User]
}
