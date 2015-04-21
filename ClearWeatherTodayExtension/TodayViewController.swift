//
//  TodayViewController.swift
//  ClearWeatherTodayExtension
//
//  Created by Kenichi Saito on 4/19/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation

class TodayViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var locationManager : CLLocationManager!
    var updateResult : NCUpdateResult!
    
    var index = Int()
    
    override func awakeFromNib()  {
        super.awakeFromNib()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        
        updateResult = .NoData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        index = 0
        locationManager.startUpdatingLocation()

        nextButton.imageView?.tintColor = UIColor.whiteColor()
        nextButton.setImage(self.image(), forState: .Normal)
        imageView.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool)  {
        super.viewDidDisappear(animated)
        
        locationManager.stopUpdatingLocation()
    }
}

extension TodayViewController {
    
    @IBAction func nextAction(sender: AnyObject) {
        
        if index < 6 {
            index++
            setData()
        } else {
            index = 0
            setData()
        }
    }
    
    func refresh(lat: Double, lng: Double) {
        
        weak var weakSelf = self
        
        ModelManager.sharedManager.reloadDailyWeather(lat, lng: lng, callback: {error in
            if error != nil {
                println(error)
            } else {
                weakSelf?.index = 0
                weakSelf?.setData()
            }
        })
    }
    
    func setData() {

        FCAnimation().performAnimation(self.imageView, duration: 1, delay: 0.3, type: .FadeIn)
        FCAnimation().performAnimation(self.locationLabel, duration: 1, delay: 0, type: .FadeIn)
        FCAnimation().performAnimation(self.tempLabel, duration: 1, delay: 0.3, type: .FadeIn)
        FCAnimation().performAnimation(self.descriptionLabel, duration: 1, delay: 0.6, type: .FadeIn)

        self.imageView.image = UIImage(named: ModelManager.sharedManager.list[index].main)?.imageWithRenderingMode(.AlwaysTemplate)
        self.locationLabel.text = ModelManager.sharedManager.list[index].name
        self.dateLabel.text = ModelManager.sharedManager.list[index].dt
        self.descriptionLabel.text = ModelManager.sharedManager.list[index].aDescription
        self.tempLabel.text = ModelManager.sharedManager.list[index].max

    }
    
    func image() -> UIImage {
        let image = UIImage(named: "1429575936_basics-02-128")!.imageWithRenderingMode(.AlwaysTemplate)
        return image
    }
}

extension TodayViewController : NCWidgetProviding {
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        completionHandler(updateResult)
        updateResult = NCUpdateResult.NoData
    }
    
}

extension TodayViewController : CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var currentLocation: CLLocation? = locations.last as? CLLocation
        var lat: CLLocationDegrees? = currentLocation?.coordinate.latitude
        var lng: CLLocationDegrees? = currentLocation?.coordinate.longitude
        var dt: NSDate! = currentLocation?.timestamp
        
        if abs(dt.timeIntervalSinceNow) < 5.0 {
            refresh(lat!, lng: lng!)
        }
        
        locationManager.stopUpdatingLocation()
        updateResult = .NewData
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        updateResult = .NewData
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
            updateResult = .Failed
    }
    
}