//
//  RegisterViewController.swift
//  homework8
//
//  Created by Hui Juhn Kim on 11/11/24.
//

import UIKit

class RegisterViewController: UIViewController {

    let registerView = RegisterView()
    let chatListViewController = ChatListViewController()
    
    override func loadView() {
        view = registerView
        self.title = "New Account"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(onButtonRegisterTapped))
    }
    
    @objc func onButtonRegisterTapped() {
        // unwrap optionals
        if let uwName = registerView.textFieldName.text,
           let uwEmail = registerView.textFieldEmail.text,
           let uwPassword = registerView.textFieldPassword.text,
           let uwConfirmPassword = registerView.textFieldConfirmPassword.text {
            
            // no text inputs should be empty
            if uwName.isEmpty || uwEmail.isEmpty || uwPassword.isEmpty || uwConfirmPassword.isEmpty {
                displayAlert(view: self, title: "Empty Input", message: "No text inputs should be empty.")
                return
            }
            
            // email should be in proper format
            if !isValidEmail(email: uwEmail) {
                displayAlert(view: self, title: "Invalid Email", message: "Email should be in proper format.")
                return
            }
            
            // password should be at least 6 characters long
            if uwPassword.count < 6 {
                displayAlert(view: self, title: "Short Password", message: "Password should be at least 6 characters long.")
            }
            
            // text fields in password and confirm password should match
            if uwPassword != uwConfirmPassword {
                displayAlert(view: self, title: "Passwords Mismatch", message: "Passwords don't match.")
            }
            
            // TODO: send info to Firestore
        }
        
        navigationController?.pushViewController(chatListViewController, animated: true)
    }
}
