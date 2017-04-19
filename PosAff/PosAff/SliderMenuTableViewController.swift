//
//  SliderMenuTableViewController.swift
//  PosAff
//
//  Created by Cody Fazio on 4/18/17.
//  Copyright © 2017 Cody Fazio. All rights reserved.
//

import UIKit
import Firebase

class SliderMenuTableViewController: UITableViewController {

    
    var tabController : UITabBarController?
    
    //MARK: Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: UITableView Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "Logout"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        handleLogout()
    }
    
    //MARK: Helper Methods
    private func handleLogout(){
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        dismiss(animated: true){
            self.tabController?.present(LoginController(), animated: true, completion: nil)
        }
    }
}
