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
    
    init(name: String, text: String, dateAndTime: String){
        self.name = name
        self.text = text
        self.dateAndTime = dateAndTime
    }
}

struct Messages: Codable{
    let messages: [Message]
}
