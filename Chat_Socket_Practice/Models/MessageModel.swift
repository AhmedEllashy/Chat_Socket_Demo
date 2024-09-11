//
//  MessageModel.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 11/09/2024.
//

import Foundation


struct MessageModel: Codable {
    var name: String?
    var message: String?
    var date: String?
    
    enum CodingKeys: String, CodingKey{
        case name = "nickname"
        case message,date
    }
}
  
