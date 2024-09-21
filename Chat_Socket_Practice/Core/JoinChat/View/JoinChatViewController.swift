//
//  JoinChatViewController.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 11/09/2024.
//

import UIKit

class JoinChatViewController: UIViewController {
    //MARK: - Properties
    
    //MARK: - UIViews
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!

    
    //MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: -  IBActions
    @IBAction func joinChatButtonPressed(_ sender: UIButton){
        if let safeText = nameTextField.text {
             UserDefaults.standard.set(safeText, forKey: "current_user")

           SocketHelper.shared.joinChatRoom(name: safeText) {
               let vc = ChatListViewController()
               vc.loggedUser = safeText
               vc.modalPresentationStyle = .fullScreen
               self.navigationController?.pushViewController(vc, animated: true)
           }
        }
    
    }

}
