//
//  TabBarVC.swift
//  Project Starter
//
//  Created by iOS Developer on 1/3/18.
//  Copyright © 2018 sawanmind. All rights reserved.
//


import UIKit
import AsyncDisplayKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        let mainvc = UINavigationController(rootViewController: MainVC())
        mainvc.tabBarItem.image = UIImage(named: "home")
        mainvc.title = "Home"
        
        let _profile = UINavigationController(rootViewController: ProfileVC())
        _profile.tabBarItem.image = UIImage(named: "profile")
        _profile.tabBarItem.badgeColor = UIColor.red
        _profile.tabBarItem.badgeValue = "9"
        _profile.title = "Profile"
        
        viewControllers = [mainvc,_profile]
    }
    
}
