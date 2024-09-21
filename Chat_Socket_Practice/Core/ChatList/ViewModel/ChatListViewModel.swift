//
//  ChatListViewModel.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 15/09/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol ChatListViewModelProtocol: AnyObject{
    var users: Observable<[UserModel]> {get}
    func getUsersList(without loggedUser: String)}


class ChatListViewModel: NSObject,ChatListViewModelProtocol{
    
   private var usersPublishSubject: PublishSubject<[UserModel]> = PublishSubject<[UserModel]>()
    var users: Observable<[UserModel]> {
        return usersPublishSubject
    }
    
    func getUsersList(without loggedUser: String){
        SocketHelper.shared.getUsersList { userList in
            guard let userlist = userList else{return}
            var users: [UserModel] = []
            users = userlist
            
            users = users.filter { user in
                user.nickname != loggedUser
            }
            print("Users is \(users)")
            self.usersPublishSubject.onNext(users)
        }
    }
}
