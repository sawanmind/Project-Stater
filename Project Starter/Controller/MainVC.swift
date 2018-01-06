//
//  ViewController.swift
//  Project Starter
//
//  Created by iOS Developer on 1/3/18.
//  Copyright © 2018 sawanmind. All rights reserved.
//

import UIKit
@objcMembers

class MainVC: UIViewController, DrawerControllerDelegate {

    var drawer = Drawer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        navigationItem.title = "MainVC"
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menu"), style: .done, target: self, action: #selector(handleMenu))
    }

    
    @objc fileprivate func handleMenu(){
     
        var array = [DrawerModel]()
        
        let Notification = DrawerModel.init(icon: #imageLiteral(resourceName: "icon"), text: "Notification", controller: ProfileVC())
        let Favourite = DrawerModel.init(icon: #imageLiteral(resourceName: "bookmark_ribbon"), text: "Favourite", controller: ProfileVC())
        let Comments = DrawerModel.init(icon: #imageLiteral(resourceName: "comments"), text: "Comments", controller: ProfileVC())
        let About = DrawerModel.init(icon: #imageLiteral(resourceName: "about"), text: "About", controller: ProfileVC())
        let Settings = DrawerModel.init(icon: #imageLiteral(resourceName: "settings"), text: "Settings", controller: ProfileVC())
        
        
        array.append(Notification)
        array.append(Favourite)
        array.append(Comments)
        array.append(About)
        array.append(Settings)
        
        drawer = Drawer(elements: array, controller: self)
        drawer.avatarImage.image = UIImage(named:"images")
        drawer.delegate = self
        drawer.show()
    }
    
    func didTapButton(type: ButtonType) {
        print(type)
    }
    
    
    func pushTo(viewController: UIViewController) {
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
  
}



