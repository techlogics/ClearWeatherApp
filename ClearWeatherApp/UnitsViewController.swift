//
//  UnitsViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 3/16/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class UnitsViewController: UIViewController {

    var mySwitch: UISwitch!
    var myLabel: UILabel!
    var exLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        
        mySwitch = UISwitch()
        mySwitch.layer.position = CGPoint(x: self.view.bounds.width/2, y: 200)
        mySwitch.backgroundColor = UIColor.clearColor()
        mySwitch.tintColor = UIColor.clearColor()
        mySwitch.addTarget(self, action: "onClickMySwicth:", forControlEvents: .ValueChanged)
        
        myLabel = UILabel(frame: CGRectMake(0, 0, 150, 50))
        myLabel.backgroundColor = UIColor.blackColor()
        myLabel.layer.borderColor = UIColor.orangeColor().CGColor
        myLabel.layer.borderWidth = 1.0
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = 20.0
        myLabel.textColor = UIColor.whiteColor()
        myLabel.font = UIFont(name: "HelveticaNeue-Light", size: 40)
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        
        exLabel = UILabel(frame: CGRectMake(0, 0, 150, 50))
        exLabel.backgroundColor = UIColor.blackColor()
        exLabel.textColor = UIColor.whiteColor()
        exLabel.font = UIFont(name: "HelveticaNeue-UrtraLight", size: 15)
        exLabel.textAlignment = NSTextAlignment.Center
        exLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: 237)
        exLabel.text = "Tap to change"

        self.view.addSubview(mySwitch)
        self.view.addSubview(exLabel)
        self.view.addSubview(myLabel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.blackColor()
        
        let ud = NSUserDefaults.standardUserDefaults()
        if ud.boolForKey("CorF") {
            mySwitch.on = ud.boolForKey("CorF")
            myLabel.text = "°C"
        } else {
            mySwitch.on = false
            myLabel.text = "°F"
        }
    }
    
    func onClickMySwicth(sender: UISwitch){
        if (sender.on == true) {
            FCAnimation().performAnimation(myLabel, duration: 0.5, delay: 0, type: .Pop)
            myLabel.text = "°C"
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setBool(true, forKey : "CorF")
            ud.synchronize()
        } else {
            FCAnimation().performAnimation(myLabel, duration: 0.5, delay: 0, type: .Pop)
            myLabel.text = "°F"
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setBool(false, forKey : "CorF")
            ud.synchronize()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        super.preferredStatusBarStyle()
        
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        for touch: AnyObject in touches {
            var t: UITouch = touch as UITouch
            if t.view.tag == self.myLabel.tag {
                onClickMySwicth(self.mySwitch)
            }
        }
    }
}
