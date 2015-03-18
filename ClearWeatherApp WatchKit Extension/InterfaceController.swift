//
//  InterfaceController.swift
//  ClearWeatherApp WatchKit Extension
//
//  Created by Kenichi Saito on 3/10/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherImageView: WKInterfaceImage!
    @IBOutlet weak var weatherLabel: WKInterfaceLabel!
    @IBOutlet weak var weatherPlaceLabel: WKInterfaceLabel!
    
    @IBOutlet weak var weatherTempLabel: WKInterfaceLabel!
    
    var locationManager: CLLocationManager!
    
    override init() {
        super.init()
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
        println("will active")
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let locations = manager.location.coordinate
        
        WKInterfaceController.openParentApplication(["lat": locations.latitude, "lng": locations.longitude], reply: {replyDict, error in
            println(replyDict)
            
            if let temp_min = replyDict["temp_min"] as? String {
                if let temp_max = replyDict["temp_max"] as? String {
                    let tempStr = "L: \(temp_min) H: \(temp_max)"
                    self.weatherTempLabel.setText(tempStr)
                }
            }
            
            self.weatherPlaceLabel.setText(replyDict["name"] as? String)
            self.weatherLabel.setText(replyDict["description"] as? String)
            
            let image = UIImage(named: replyDict["main"] as String)?.imageWithRenderingMode(.AlwaysTemplate)
            
            self.weatherImageView.setImage(image)
        })
        
        manager.stopUpdatingLocation()
    }

    override func didDeactivate() {
        super.didDeactivate()
        locationManager.delegate = nil
    }
}
