//
//  RegisterView.swift
//  homework8
//
//  Created by Hui Juhn Kim on 11/11/24.
//

import UIKit

class RegisterView: UIView {
    
    var labelName: UILabel!
    var textFieldName: UITextField!
    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    var labelConfirmPassword: UILabel!
    var textFieldConfirmPassword: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelName()
        setupTextFieldName()
        setupLabelEmail()
        setuptextFieldEmail()
        setupLabelPassword()
        setupTextFieldPassword()
        setupLabelConfirmPassword()
        setupTextFieldConfirmPassword()
        
        initConstraints()
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Name:"
        labelName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelName)
    }
    
    func setupTextFieldName() {
        textFieldName = UITextField()
        textFieldName.textContentType = .name
        textFieldName.textAlignment = .center
        textFieldName.placeholder = "Enter your name"
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textFieldName)
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
        textFieldEmail.textAlignment = .center
        textFieldEmail.autocapitalizationType = .none
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
        textFieldPassword.textAlignment = .center
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.placeholder = "Enter Password"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupLabelConfirmPassword() {
        labelConfirmPassword = UILabel()
        labelConfirmPassword.text = "Confirm Password:"
        labelConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelConfirmPassword)
    }
    
    func setupTextFieldConfirmPassword() {
        textFieldConfirmPassword = UITextField()
        textFieldConfirmPassword.textContentType = .password
        textFieldConfirmPassword.isSecureTextEntry = true
        textFieldConfirmPassword.textAlignment = .center
        textFieldConfirmPassword.borderStyle = .roundedRect
        textFieldConfirmPassword.placeholder = "Enter Password"
        textFieldConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldConfirmPassword)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
            
            textFieldName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldName.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 32),
            textFieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            labelEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 32),
            
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
            
            labelConfirmPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelConfirmPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
            
            textFieldConfirmPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldConfirmPassword.topAnchor.constraint(equalTo: labelConfirmPassword.bottomAnchor, constant: 32),
            textFieldConfirmPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldConfirmPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
