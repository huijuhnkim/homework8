//
//  BarButtonManager.swift
//  homework8
//
//  Created by Charles Yang on 11/13/24.
//

import UIKit
import FirebaseAuth

extension ChatListViewController{
    func setupLeftBarButton(isLoggedin: Bool){
        if isLoggedin{
            //MARK: user is logged in...
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "gearshape"),
                style: .plain,
                target: self,
                action: #selector(showUserProfile)
            )
            let barText = UIBarButtonItem(
                title: "User Profile",
                style: .plain,
                target: self,
                action: #selector(showUserProfile)
            )
            
            navigationItem.rightBarButtonItems = [barIcon, barText]
            
        }else{
            //MARK: not logged in...
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "person.fill.questionmark"),
                style: .plain,
                target: self,
                action: #selector(onSignInBarButtonTapped)
            )
            let barText = UIBarButtonItem(
                title: "Sign in",
                style: .plain,
                target: self,
                action: #selector(onSignInBarButtonTapped)
            )
            
            navigationItem.rightBarButtonItems = [barIcon, barText]
        }
    }
    
    @objc func onSignInBarButtonTapped(){
        let signInAlert = UIAlertController(
            title: "Sign In / Register",
            message: "Please sign in to continue.",
            preferredStyle: .alert)
        
        //MARK: setting up email textField in the alert...
        signInAlert.addTextField{ textField in
            textField.placeholder = "Enter email"
            textField.contentMode = .center
            textField.keyboardType = .emailAddress
        }
        
        //MARK: setting up password textField in the alert...
        signInAlert.addTextField{ textField in
            textField.placeholder = "Enter password"
            textField.contentMode = .center
            textField.isSecureTextEntry = true
        }
        
        //MARK: Sign In Action...
        let signInAction = UIAlertAction(title: "Sign In", style: .default, handler: {(_) in
            if let email = signInAlert.textFields![0].text,
               let password = signInAlert.textFields![1].text{
                //MARK: sign-in logic for Firebase...
                self.signInToFirebase(email: email, password: password)
            }
        })
        
        //MARK: Register Action...
        let registerAction = UIAlertAction(title: "Register", style: .default, handler: {(_) in
            //MARK: logic to open the register screen...
            let registerViewController = RegisterViewController()
            self.navigationController?.pushViewController(registerViewController, animated: true)
        })
        
        
        //MARK: action buttons...
        signInAlert.addAction(signInAction)
        signInAlert.addAction(registerAction)
        
        self.present(signInAlert, animated: true, completion: {() in
            //MARK: hide the alerton tap outside...
            signInAlert.view.superview?.isUserInteractionEnabled = true
            signInAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
    }
    @objc func onTapOutsideAlert(){
        self.dismiss(animated: true)
    }
    
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
    
    @objc func showUserProfile() {
            guard let user = Auth.auth().currentUser else {
                showAlert(title: "No User Found", message: "Please log in to view profile.")
                return
            }
            
            let profileAlert = UIAlertController(title: "User Profile", message: nil, preferredStyle: .alert)
            let username = user.displayName ?? "Unknown"
            let useremail = user.email
            let message = "Username: \(username)\nUser Email: \(useremail)"
            profileAlert.message = message
            
            profileAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            profileAlert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in self.onLogOutBarButtonTapped()}))
            
            self.present(profileAlert, animated: true)
        }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func signInToFirebase(email: String, password: String){
        //MARK: can you display progress indicator here?
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: user authenticated...
                //MARK: can you hide the progress indicator here?
            }else{
                //MARK: alert that no user found or password wrong...
            }
            
        })
    }
    
}