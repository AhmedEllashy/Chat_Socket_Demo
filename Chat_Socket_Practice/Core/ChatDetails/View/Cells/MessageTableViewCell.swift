//
//  MessageTableViewCell.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 21/09/2024.
//

import UIKit
import RxSwift

class MessageTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private var isCurrentUser: Bool = true

    //MARK: - UIViews
    @IBOutlet weak var messageStackView: UIStackView!
    @IBOutlet weak var messgaeBodyTextView: UITextView!
    
    @IBOutlet weak var messageDateLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 100, right: 10))
        messgaeBodyTextView.layer.masksToBounds = true
        messgaeBodyTextView.layer.cornerRadius = 15.0
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    //MARK: - Helpers
    func config(with message: MessageModel){
       let currentUserName = UserDefaults.standard.string(forKey: "current_user")
        print("current_usr: \(currentUserName)")
        if message.name != currentUserName {
            isCurrentUser = true
            messgaeBodyTextView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            messgaeBodyTextView.textColor = .black
            messgaeBodyTextView.textAlignment = .right
            messageStackView.alignment = .trailing

          
        }else{
            isCurrentUser = false
            messgaeBodyTextView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            messgaeBodyTextView.textColor = .black
            messgaeBodyTextView.textAlignment = .left
            messageStackView.alignment = .leading


        }
        var body  = "\(message.message ?? "") "
        messgaeBodyTextView.text = body
        messageDateLabel.text = message.date
    }

    //MARK: - Cell Config
    static let identifer: String = "MessageTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifer, bundle: nil)
    }

    
}
