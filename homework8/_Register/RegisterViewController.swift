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
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = registerView
        self.title = "New Account"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(onButtonRegisterTapped))
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    @objc func onButtonRegisterTapped() {
        registerNewAccount()
    }
    
}
