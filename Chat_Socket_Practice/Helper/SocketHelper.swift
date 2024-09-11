//
//  SocketHelper.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 11/09/2024.
//

import Foundation
import SocketIO

let kHost = "http://192.168.0.133:3001"
let kConnectUser = "connectUser"
let kUserList = "userList"
let kExitUser = "exitUser"
var kSendMessage = "chatMessage"
var knewChatMessage = "newChatMessage"

class SocketHelper: NSObject {
    static let shared = SocketHelper()
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    
    private func configSocketClient(){
        guard let url = URL(string: kHost) else{
            return
        }
        manager = SocketManager(socketURL: url, config: [.log(true),.compress])
        guard let manager = manager else {
            return
        }
        socket = SocketIOClient(manager: manager, nsp: "/**********")
    }
    func startConnection(){
        guard let socket = manager?.defaultSocket else{
            return
        }
        socket.connect()
    }
    func closeConnection(){
        guard let socket = manager?.defaultSocket else{
              return
          }
        socket.disconnect()
    }
    
    func joinChatRoom(name: String,completion:@escaping (()-> Void)){
        guard let socket = manager?.defaultSocket else{
              return
          }
        socket.emit(kConnectUser, name)
        completion()
    }
    
    func exitChatRoom(name: String, completion: @escaping () -> Void){
        guard let socket = manager?.defaultSocket else{
              return
          }
        socket.emit(kExitUser, name)
        completion()
    }
    
    func getUsersList(completion: @escaping (_ userList: [UserModel]?)-> Void){
        guard let socket = manager?.defaultSocket else{
              return
          }
        socket.on(kUserList) {[weak self] (results,_) in
            guard results.count > 0,
                  let _ = self,
                  let user = results.first as? [[String:Any]] else{
                return
            }
            do {
                let userData = try JSONSerialization.data(withJSONObject: user)
                let users = try JSONDecoder().decode([UserModel].self, from: userData)
                completion(users)
            }catch{
                print("error Occured \(error)")
                completion(nil)

                
            }
            
        }
    }
    func sendMessage(message: String ,with name: String){
        guard let socket = manager?.defaultSocket else{
            return
        }
        socket.emit(kSendMessage, name, message)
    }
    func getMessage(completion: @escaping (_ message: MessageModel?) -> Void){
        guard let socket = manager?.defaultSocket else{
            return
        }
        socket.on(knewChatMessage) { [weak self] (result, ack) in
            var messageInfo = [String:Any]()
            guard let name = result[0] as? String,
                  let message = result[1] as? String,
                  let date  = result[2] as? String else{
                return
            }
            messageInfo["nickname"] = name
            messageInfo["message"] = message
            messageInfo["date"] = date
            do {
                 let messageData = try JSONSerialization.data(withJSONObject: messageInfo)
                let message = try JSONDecoder().decode(MessageModel.self, from: messageData)
                completion(message)
                        
            }catch{
                print("error Occured \(error)")
                completion(nil)
            }

            
        }
    }
}
