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

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForUserAuthorization()
    }
    
    
    //MARK: Helper Methods
    func checkForUserAuthorization() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0.0)
            handleLogout()
        }

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

