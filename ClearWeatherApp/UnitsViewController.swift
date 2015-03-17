//
//  UnitsViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 3/16/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class UnitsViewController: UIViewController {
    
    
    
    var mySwitch : UISwitch!
    var myLabel : UILabel!
    let ud = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.blackColor()
        
        

        let mySwicth: UISwitch = UISwitch()
        mySwicth.layer.position = CGPoint(x: self.view.frame.width/2, y: 300)
        
        mySwicth.backgroundColor = UIColor.blackColor()
        mySwicth.tintColor = UIColor.whiteColor()
        

        mySwicth.on = true
        
        mySwicth.addTarget(self, action: "onClickMySwicth:", forControlEvents: UIControlEvents.ValueChanged)
        
        
        self.view.addSubview(mySwicth)
        
        myLabel = UILabel(frame: CGRectMake(0,0,200,50))
        
        myLabel.backgroundColor = UIColor.blackColor()
        myLabel.layer.borderColor = UIColor.greenColor().CGColor
        myLabel.layer.borderWidth = 1.0
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = 10.0
        myLabel.textColor = UIColor.whiteColor()
        myLabel.font = UIFont(name: "HelveticaNeue", size: 40)
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        

        self.view.addSubview(myLabel)
        
        
        let ud = NSUserDefaults.standardUserDefaults()
        
        mySwicth.on = ud.boolForKey("CorF")
        
        onClickMySwicth(mySwicth)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func onClickMySwicth(sender: UISwitch){
        
        if (sender.on == true)
        {
            myLabel.text = "°C"
            ud.setBool(true
                , forKey : "CtoF")
        }
        else
        {
            myLabel.text = "°F"
            ud.setBool(false, forKey : "CtoF")
        }
        
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
