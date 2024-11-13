//
//  RegisterViewController.swift
//  homework8
//
//  Created by Hui Juhn Kim on 11/11/24.
//

import UIKit

class RegisterViewController: UIViewController {

    let registerView = RegisterView()
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = registerView
        self.title = "New Account"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(onButtonRegisterTapped))
    }
    
    @objc func onButtonRegisterTapped() {
        registerNewAccount()
        let chatListViewController = ChatListViewController()
        navigationController?.pushViewController(chatListViewController, animated: true)
    }
}
