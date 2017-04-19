//
//  AffirmationTableViewController.swift
//  PosAff
//
//  Created by Cody Fazio on 4/18/17.
//  Copyright © 2017 Cody Fazio. All rights reserved.
//

import UIKit
import Firebase

class AffirmationTableViewController: UITableViewController {

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleNewAffirmation))
        checkForUserAuthorization()
    }
    
    
    //MARK: Helper Methods
    func checkForUserAuthorization() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0.0)
            handleLogout()
        } else {
            guard let uid = FIRAuth.auth()?.currentUser?.uid else {
                print("Something went wrong getting uid.")
                return
            }
            
            FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(
                of: .value, with: {snapshot in
                    
                    if let dictionary = snapshot.value as? [String: Any] {
                    //TODO: Use user info to customize view
                    }
            })
        }

    }
    
    func handleNewAffirmation() {
        
        let newAffirmationController = NewAffirmationController(style: .grouped)
        let navController = UINavigationController(rootViewController: newAffirmationController)
        present(navController, animated: true, completion: nil)
    }
    
    func handleLogout(){
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        self.tabBarController?.present(loginController, animated: true, completion: nil)
    }
}

