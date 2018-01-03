//
//  ViewController.swift
//  Project Starter
//
//  Created by iOS Developer on 1/3/18.
//  Copyright © 2018 sawanmind. All rights reserved.
//

import UIKit
@objcMembers

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        navigationItem.title = "MainVC"
        
    }

  
  
}



