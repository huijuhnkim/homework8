//
//  ViewController.swift
//  homework8
//
//  Created by Hui Juhn Kim on 11/11/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    let loginView = LoginView()
    let chatListView = ChatListView()
    let registerViewController = RegisterViewController()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                // not signed in...
                self.currentUser = nil
                return
            } else {
                // user is signed in
                self.currentUser = user
                return
            }
        }
    }
    
    override func loadView() {
        if currentUser == nil {
            view = loginView
        } else {
            view = chatListView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Login"
        
        // register button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.plus"), style: .plain, target: self, action: #selector(onButtonRegisterTapped))
        
        // sign in button
        loginView.buttonLogin.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    @objc func onButtonRegisterTapped() {
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc func onButtonLoginTapped() {
        if let email = loginView.textFieldEmail.text, let password = loginView.textFieldPassword.text {
            // text fields should not be empty
            if email.isEmpty || password.isEmpty {
                displayAlert(viewController: self, title: "Empty Fields", message: "Please fill in all text fields.")
                return
            }
            
            // perform authentication
            
            
        }
    }
}

