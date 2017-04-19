//
//  TabController.swift
//  PosAff
//
//  Created by Cody Fazio on 4/18/17.
//  Copyright © 2017 Cody Fazio. All rights reserved.
//

import UIKit
import Firebase

class TabController: UITabBarController {

    //MARK: Properties
    lazy var slideInTransitionDelegate = SlideInPresentationManager()

    //MARK: Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupControllers()
        tabBar.isHidden = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(tappedMenuButton))
    }
    
    //MARK: Helper Methods
    func setupControllers() {
        
        let affirmationController = AffirmationTableViewController()
        self.viewControllers = [affirmationController]
    }
    
    
    func tappedMenuButton() {
    
        let menuController = SliderMenuTableViewController(style: .grouped)
        let navController = UINavigationController(rootViewController: menuController)
        
        slideInTransitionDelegate.direction = .left
        navController.transitioningDelegate = slideInTransitionDelegate
        navController.modalPresentationStyle = .custom
        menuController.tabController = self
        
        present(navController, animated: true, completion: nil)
    }
}
