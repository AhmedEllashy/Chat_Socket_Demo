//
//  ChatDetailsViewModel.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 15/09/2024.
//

import Foundation
import RxSwift
import RxCocoa
protocol ChatDetailsProtocol{
    var messages: Observable<[MessageModel]> {get}
    func getMessages()
    func sendMessage(message: String,from name: String)
}

class ChatDetailsViewModel: NSObject,ChatDetailsProtocol{

    private var messagesBehaviorSubject = BehaviorSubject<[MessageModel]>(value: [])

    var messages: Observable<[MessageModel]>{
        return messagesBehaviorSubject
    }

    func getMessages() {
        SocketHelper.shared.getMessage { message in
            if let safeMessage = message {
        
                if var value = try? self.messagesBehaviorSubject.value() {
                    value.append(safeMessage)
                    DispatchQueue.main.async { // ensure UI updates are done on main thread
                    self.messagesBehaviorSubject.on(.next(value))
                    }
                }
            }
            
        }
    }
    func sendMessage(message: String,from name: String) {
        SocketHelper.shared.sendMessage(message: message, from: name)
    }
    
}
