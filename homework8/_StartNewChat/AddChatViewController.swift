//
//  AddChatViewController.swift
//  homework8
//
//  Created by Charles Yang on 11/14/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddChatViewController: UIViewController {

    let addChatScreen = AddChatView()
    
    var userList = [User]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = addChatScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            self.currentUser = user
            self.database.collection("users").addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.userList.removeAll()
                    for document in querySnapshot!.documents {
                        do {
                            let user = try document.data(as: User.self)
                            self.userList.append(user)
                        } catch {
                            print("Error decoding user: \(error)")
                        }
                    }
                    self.userList.sort(by: { $0.name < $1.name })
                    self.addChatScreen.tableViewUsers.reloadData()
                }
            })
        }
        
        title = "Start New Chat"
        
        //MARK: patching table view delegate and data source...
        addChatScreen.tableViewUsers.delegate = self
        addChatScreen.tableViewUsers.dataSource = self
        
        //MARK: removing the separator line...
        addChatScreen.tableViewUsers.separatorStyle = .none
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
}