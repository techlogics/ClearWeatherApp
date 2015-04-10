//
//  LicenseViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 3/18/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController {
    
    var textView: UITextView!
    
    override func loadView() {
        super.loadView()
        
        textView = UITextView(frame: UIScreen.mainScreen().bounds)
        textView.editable = false
        textView.backgroundColor = UIColor.blackColor()
        textView.textColor = UIColor.whiteColor()
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        
        let filePath = NSBundle.mainBundle().pathForResource("Lisence", ofType: "txt")
        let text = NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        
        textView.text = text as! String
        
        self.view.addSubview(textView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        super.preferredStatusBarStyle()
        
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
