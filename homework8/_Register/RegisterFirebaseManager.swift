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
                displayAlert(viewController: self, title: "Empty Fields", message: "There are empty fields. Please fill in all fields.")
                return
            }
            
            if !isValidEmail(email: email) {
                displayAlert(viewController: self, title: "Invalid Email", message: "Email should be in proper format.")
                return
            }
            
            if password != confirmPassword {
                displayAlert(viewController: self, title: "Password Mismatch", message: "Password does not match.")
                return
            }
            
//            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
//                if error == nil{
//                    self.hideActivityIndicator()
//                    self.setNameOfTheUserInFirebaseAuth(name: name)
//                    print("user created")
//                } else {
//                    print(error as Any)
//                }
//            })
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    // self.displayAlert(viewController: self, title: "Registration Error", message: error.localizedDescription)
                    self.hideActivityIndicator()
                } else if let user = authResult?.user {
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
        ]) { error in
            if let error = error {
                // self.displayAlert(viewController: self, title: "Firestore Error", message: error.localizedDescription)
                self.hideActivityIndicator()
            } else {
                self.setNameOfTheUserInFirebaseAuth(name: name, user: user)
            }
        }
    }

    func setNameOfTheUserInFirebaseAuth(name: String, user: FirebaseAuth.User) {
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.commitChanges { error in
            if let error = error {
                // self.displayAlert(viewController: self, title: "Profile Update Error", message: error.localizedDescription)
                self.hideActivityIndicator()
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //MARK: We set the name of the user after we create the account...
//    func setNameOfTheUserInFirebaseAuth(name: String){
//        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//        changeRequest?.displayName = name
//        changeRequest?.commitChanges(completion: {(error) in
//            if error == nil{
//                //MARK: the profile update is successful...
//                self.navigationController?.popViewController(animated: true)
//            }else{
//                //MARK: there was an error updating the profile...
//                print("Error occured: \(String(describing: error))")
//            }
//        })
//    }
}
