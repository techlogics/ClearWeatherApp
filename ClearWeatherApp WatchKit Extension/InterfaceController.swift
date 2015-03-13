//
//  InterfaceController.swift
//  ClearWeatherApp WatchKit Extension
//
//  Created by Kenichi Saito on 3/10/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var weatherImageView: WKInterfaceImage!
    @IBOutlet weak var weatherLabel: WKInterfaceLabel!
    @IBOutlet weak var weatherPlaceLabel: WKInterfaceLabel!
    
    @IBOutlet weak var weatherTempLabel: WKInterfaceLabel!
    override init() {
        super.init()
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        println("will active")
        
        WKInterfaceController.openParentApplication(["": ""], reply: {replyDict, error in
            println(replyDict)
            
            let data = replyDict as Dictionary
            
            if let temp_min = data["temp_min"] as? String {
                if let temp_max = data["temp_max"] as? String {
                    let tempStr = "L: \(temp_min) H: \(temp_max)"
                    self.weatherTempLabel.setText(tempStr)
                }
            }
            
            self.weatherPlaceLabel.setText(data["name"] as? String)
            self.weatherLabel.setText(data["description"] as? String)
            
            let image = UIImage(named: data["main"] as String)?.imageWithRenderingMode(.AlwaysTemplate)
            
            self.weatherImageView.setImage(image)
        })
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
