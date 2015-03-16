//
//  MenuNavigationController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 3/9/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class MenuNavigationController: UINavigationController {
    
    var menu: MediumMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationBar.shadowImage = UIImage()
        
        let homeVC = HomeViewController()
        setViewControllers([homeVC], animated: false)
        
        let item1: MediumMenuItem = MediumMenuItem(menuItemWithTitle: "Home", withCompletionHandler: {(finished: Bool) -> () in
            let homeVC =  HomeViewController()
            self.setViewControllers([homeVC], animated: false)
        })
        
        let item2: MediumMenuItem = MediumMenuItem(menuItemWithTitle: "Settings", withCompletionHandler: {(finished: Bool) -> () in
            let settingVC = SettingsViewController()
            self.setViewControllers([settingVC], animated: false)
        })
        
        menu = MediumMenu(Items: [item1, item2], andTextAlignment: .Left, forViewController: self)
    }
    
    func showMenu() {
        menu?.showMenu()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
}

extension UINavigationBar {
    public override func sizeThatFits(size: CGSize) -> CGSize {
        var newsize: CGSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 60)
        return newsize
    }
}

