//
//  SettingsViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 3/9/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class SettingsViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        let kScreenSize = UIScreen.mainScreen().bounds.size
        
        tableView = UITableView(frame: CGRectMake(0, 0, kScreenSize.width, kScreenSize.height), style: .Grouped)
        
        self.view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = WeatherTableViewCell(style: .Default, reuseIdentifier: "Cell")
        updateCell(cell, indexPath: indexPath)
        return cell
    }
    
    func updateCell(cell: WeatherTableViewCell, indexPath: NSIndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
