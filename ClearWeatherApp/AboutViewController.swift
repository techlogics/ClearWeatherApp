//
//  AboutViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 3/16/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit
import MessageUI


class AboutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    
    let settingsTitle = [
        "Version",
        "License",
        "Feedback"
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsTitle.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell")
        cell.backgroundColor = UIColor.blackColor()
        cell.selectionStyle = .None
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        
        cell.textLabel?.text = settingsTitle[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.detailTextLabel?.text = "1.0.0"
        case 1:
            cell.accessoryType = .DisclosureIndicator
        case 2:
            cell.accessoryType = .DisclosureIndicator
        default:
            break // do nothing
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 1:
            let licenseVC = LicenseViewController()
            let backButton = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem = backButton
            self.navigationController?.pushViewController(licenseVC, animated: true)
        case 2:
            let url = NSURL(string: "http://farconnection.co.jp/contact/")!
            UIApplication.sharedApplication().openURL(url)
        default:
            break // do nothing
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.blackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
