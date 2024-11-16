//
//  RegisterFirebaseManager.swift
//  homework8
//
//  Created by Hui Juhn Kim on 11/12/24.
//
//

import Foundation
import FirebaseAuth
import Firebase

extension RegisterViewController{
    
    func registerNewAccount(){
        showActivityIndicator()
        
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text,
           let confirmPassword = registerView.textFieldConfirmPassword.text {

            // input validations
            if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                displayAlert(title: "Empty Fields", message: "There are empty fields. Please fill in all fields.")
                return
            }
            
            if !isValidEmail(email: email) {
                displayAlert(title: "Invalid Email", message: "Email should be in proper format.")
                return
            }
            
            if password != confirmPassword {
                displayAlert(title: "Password Mismatch", message: "Password does not match.")
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.displayAlert(title: "Registration Error", message: error.localizedDescription)
                    self.hideActivityIndicator()
                } else if let user = authResult?.user {
                    print("add user to fire store")
                    self.addUserToFirestore(user: user, name: name, email: email)
                }
            }
        }
    }
    
    func addUserToFirestore(user: FirebaseAuth.User, name: String, email: String) {
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).setData([
            "name": name,
            "email": email,
            "uid": user.uid,
        ]) { error in
            if let error = error {
                self.displayAlert(title: "Firestore Error", message: error.localizedDescription)
                self.hideActivityIndicator()
            } else {
                print("set name of the user in firebase auth")
                self.setNameOfTheUserInFirebaseAuth(name: name, user: user)
            }
        }
    }

    func setNameOfTheUserInFirebaseAuth(name: String, user: FirebaseAuth.User) {
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.commitChanges { error in
            if let error = error {
                self.displayAlert(title: "Profile Update Error", message: error.localizedDescription)
                self.hideActivityIndicator()
            } else {
                print("jump to chat list from register")
                if let viewControllers = self.navigationController?.viewControllers {
                    for viewController in viewControllers {
                        if let mainVC = viewController as? ViewController {
                            self.navigationController?.popToViewController(mainVC, animated: true)
                            break
                        }
                    }
                }
                // self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
