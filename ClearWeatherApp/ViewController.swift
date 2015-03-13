//
//  ViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 3/9/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var icon: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "list"), style: .Plain, target: navigationController, action: "showMenu")
        icon.imageInsets = UIEdgeInsetsMake(-10, 0, 0, 0)
        icon.tintColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = icon
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
