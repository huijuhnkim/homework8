//
//  LoginView.swift
//  homework8
//
//  Created by Hui Juhn Kim on 11/11/24.
//

import UIKit

class LoginView: UIView {
    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelEmail()
        setuptextFieldEmail()
        setupLabelPassword()
        setupTextFieldPassword()
        setupButtonLogin()
        
        initConstraints()
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.text = "Email:"
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setuptextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.textContentType = .emailAddress
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.textAlignment = .center
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.placeholder = "Enter Email"
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setupLabelPassword() {
        labelPassword = UILabel()
        labelPassword.text = "Password:"
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPassword)
    }
    
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.textAlignment = .center
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.placeholder = "Enter Password"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelEmail.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
            
            textFieldEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 32),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            labelPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 32),
            
            textFieldPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 32),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            buttonLogin.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonLogin.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -60),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
