//
//  User.swift
//  homework8
//
//  Created by Charles Yang on 11/14/24.
//

import Foundation

struct User: Codable{
    var name: String
    var email: String?
    var uid: String
    
    init(name: String, email: String?, uid: String){
        self.name = name
        self.email = email
        self.uid = uid
    }
}

struct Users: Codable{
    let users: [User]
}
