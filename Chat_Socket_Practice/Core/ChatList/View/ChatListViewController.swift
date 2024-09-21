//
//  ChatListViewController.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 12/09/2024.
//

import UIKit
import RxSwift
import RxCocoa
class ChatListViewController: UIViewController {
    var loggedUser: String?
    //MARK: - Properties
    var viewModel: ChatListViewModel = ChatListViewModel()
    var disposeBag = DisposeBag()
    //MARK: - UIViews
    @IBOutlet weak var usersTableView: UITableView!

    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    //MARK: - Helpers
    private func setup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(didTapAddButton))
        getUsersList()
        configTableView()
        bindTableViewToViewModel()
        didSelectRow()
    }
    private func getUsersList(){
        guard let loggedUser = loggedUser else{return}
        viewModel.getUsersList(without: loggedUser)
    }
    private func configTableView(){
        usersTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    @objc func didTapAddButton(){
        navigationController?.popViewController(animated: true)
    }
    private func bindTableViewToViewModel(){
        viewModel.users.bind(to: usersTableView.rx.items(cellIdentifier:UserTableViewCell.identifier , cellType: UserTableViewCell.self)){[weak self] (row,user,cell) in
            guard let _ = self else{return}
            print("user is : \(user)")
            cell.config(user)
        }.disposed(by: disposeBag)
    }
    private func didSelectRow(){
        usersTableView.rx.modelSelected(UserModel.self).subscribe{ item in
            let vc = ChatDetailsViewController()
            vc.user = item
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }

}
