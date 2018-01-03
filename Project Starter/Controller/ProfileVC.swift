//
//  ProfileVC.swift
//  Project Starter
//
//  Created by iOS Developer on 1/3/18.
//  Copyright © 2018 sawanmind. All rights reserved.
//

import UIKit
@objcMembers

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(didTapLogout))
        navigationItem.rightBarButtonItem?.tintColor = ThemeManager.currentTheme().barButtonColor
    }
    

    
    
}


