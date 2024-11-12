//
//  ViewController.swift
//  homework8
//
//  Created by Hui Juhn Kim on 11/11/24.
//

import UIKit

class ViewController: UIViewController {

    let loginView = LoginView()
    let registerViewController = RegisterViewController()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.plus"), style: .plain, target: self, action: #selector(onButtonRegisterTapped))
    }
    
    //TODO: navigate to RegisterView
    @objc func onButtonRegisterTapped() {
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

