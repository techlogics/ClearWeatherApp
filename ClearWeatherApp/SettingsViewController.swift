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
    
    let settingsTitle = [
        "UNITS",
        "FOLLOW US",
        "ABOUT THIS APP"
    ]
    
    override func loadView() {
        super.loadView()
        
        let kScreenSize = UIScreen.mainScreen().bounds.size
        
        tableView = UITableView(frame: CGRectMake(0, 0, kScreenSize.width, kScreenSize.height), style: .Grouped)
        tableView.backgroundColor = UIColor.blackColor()
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsTitle.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell")
        cell.backgroundColor = UIColor.blackColor()
        cell.selectionStyle = .None
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        cell.textLabel?.textColor = UIColor.whiteColor()
        updateCell(cell, indexPath: indexPath)
        return cell
    }
    
    func updateCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        cell.textLabel?.text = settingsTitle[indexPath.row]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // セルをタップした時の動作
        switch indexPath.row {
        case 0:
            let unitsVC = UnitsViewController()
            let backButton = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem = backButton
            self.navigationController?.pushViewController(unitsVC, animated: true)
        case 1:
            let followVC = FollowViewController()
            let backButton = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem = backButton
            self.navigationController?.pushViewController(followVC, animated: true)
        case 2:
            let aboutVC = AboutViewController()
            let backButton = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem = backButton
            self.navigationController?.pushViewController(aboutVC, animated: true)
        default:
            break // do nothing
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        tableView.delegate = nil
        tableView.dataSource = nil
    }
}
