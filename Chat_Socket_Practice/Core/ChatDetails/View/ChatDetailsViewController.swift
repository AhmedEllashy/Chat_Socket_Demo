//
//  ChatDetailsViewController.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 15/09/2024.
//

import UIKit
import RxSwift
import RxCocoa
class ChatDetailsViewController: UIViewController {

    //MARK: - Properties
    var disposeBag = DisposeBag()
    let viewModel = ChatDetailsViewModel()
    var user: UserModel?
    var loggedUser: UserModel?
    
    //MARK: - UIViews
     var handlersView: UIView = {
        let view = UIView()
        return view
    }()
     var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
     var messageTextField: UITextField = {
        let textfield = UITextField()
         textfield.placeholder = "Message..."
         textfield.borderStyle = .roundedRect
         return textfield
    }()
    var sendMessageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.addTarget(self, action: #selector(didTapSendMessageButton), for: .touchUpInside)
        return button
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configUIViews()

    }
    
    //MARK: - Helpers
    private func setup(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        title = user?.nickname
        viewModel.getMessages()
        configTableView()
        bindTableViewToViewModel()
        view.addSubview(tableView)
        view.addSubview(handlersView)
        handlersView.addSubview(messageTextField)
        handlersView.addSubview(sendMessageButton)
    }
    @objc private func keyboardWillShow(notification: NSNotification){
        if let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardHeight = keyboardFrame.cgRectValue.height
                handlersView.frame.origin.y = keyboardHeight + 125
                UIView.animate(withDuration: 0.3) {
                     self.handlersView.layoutIfNeeded()
                 }
             }
    }
    @objc private func keyboardWillHide(notification: NSNotification){
        if view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
    }
    @objc private func didTapSendMessageButton(){
        guard let safeText = messageTextField.text,
              let safeName = user?.nickname else{return}

        viewModel.sendMessage(message: safeText, from: safeName)
        messageTextField.text = ""
        viewModel.getMessages()
    }
    
    private func configTableView(){
        tableView.register(MessageTableViewCell.nib(), forCellReuseIdentifier: MessageTableViewCell.identifer)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

    }
    private func bindTableViewToViewModel(){
        viewModel.messages.bind(to: tableView.rx.items(cellIdentifier: MessageTableViewCell.identifer, cellType: MessageTableViewCell.self)) { [weak self] (row,message,cell) in
            guard let self = self else{return}
            
            cell.config(with: message)
            print("Debug: ViewModel messages \(self.viewModel.messages)")
        }.disposed(by: disposeBag)
        
    }
    private func configUIViews(){
        tableView.frame = view.bounds
        tableView.bringSubviewToFront(handlersView)
        handlersView.frame = CGRect(x: 10, y: view.bottom - 100, width: view.width - 30, height: 50)
        messageTextField.frame = CGRect(x: 0, y: 0, width: handlersView.width - 60, height: handlersView.height)
        sendMessageButton.layer.cornerRadius = 55 / 2
        sendMessageButton.frame = CGRect(x: messageTextField.right + 10, y: 0, width: 55, height: 55)

    }


}

extension ChatDetailsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 80
       }
}

