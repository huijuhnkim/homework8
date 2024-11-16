//
//  Message.swift
//  homework8
//
//  Created by Christina Kang on 11/12/24.
//
import Foundation

struct Message: Codable{
    var name: String
    var text: String
    var dateAndTime: String
    var uid: String
    
    init(name: String, text: String, dateAndTime: String, uid: String){
        self.name = name
        self.text = text
        self.dateAndTime = dateAndTime
        self.uid = uid
    }
}

struct Messages: Codable{
    let messages: [Message]
}
