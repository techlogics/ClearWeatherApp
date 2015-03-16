//
//  AboutViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 3/16/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDataSource {
    
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
        updateCell(cell, indexPath: indexPath)
        return cell
    }
    
    func updateCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        cell.textLabel?.text = settingsTitle[indexPath.row]
        if indexPath.row == 0 {
            cell.detailTextLabel?.text = "1.0.0"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.blackColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
