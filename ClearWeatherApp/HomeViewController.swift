//
//  ViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 2/21/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: ViewController, UITableViewDataSource, CLLocationManagerDelegate {
    
    var tableView: UITableView!
    var weatherImageView: UIImageView!
    var descriptionLabel: UILabel!
    var minLabel: UILabel!
    var maxLabel: UILabel!
    var nameLabel: UILabel!
    var refreshButton: UIBarButtonItem!
    var backImageView: UIImageView!
    var indicatorView: UIActivityIndicatorView!
    var locationManager: CLLocationManager!
    
    override func loadView() {
        super.loadView()
        
        // TableViewのsizeはデバイスの大きさに合わせる↓
        let kScreenSize = UIScreen.mainScreen().bounds.size
        
        // TableViewの配置は画面の下半分に設定
        tableView = UITableView(frame: CGRectMake(0, kScreenSize.height/2, kScreenSize.width, kScreenSize.height/2))
        tableView.backgroundColor = UIColor.clearColor()
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.separatorStyle = .None
        
        // 背景画像の設定 背景は背景の数でランダム
        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: "changeBack", userInfo: nil, repeats: true)
        backImageView = UIImageView(frame: CGRectMake(0, 0, kScreenSize.width, kScreenSize.height))
        changeBack()
        
        // それぞれのパーツ CGRectMakeでパーツの大きさを設定 CGPointMakeで配置位置を設定
        weatherImageView = UIImageView(frame: CGRectMake(0, 0, kScreenSize.width/3, kScreenSize.width/3))
        weatherImageView.tintColor = UIColor.whiteColor()
        weatherImageView.layer.position = CGPointMake(kScreenSize.width/2, kScreenSize.width/2)
        
        nameLabel = UILabel(frame: CGRectMake(0, 0, 200, 40))
        nameLabel.textColor =  UIColor.whiteColor()
        nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        nameLabel.textAlignment = .Center
        nameLabel.layer.position = CGPointMake(kScreenSize.width/2, kScreenSize.width/2 - kScreenSize.width/5)
        
        descriptionLabel = UILabel(frame: CGRectMake(0, 0, 250, 30))
        descriptionLabel.textColor = UIColor.whiteColor()
        descriptionLabel.textAlignment = .Center
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        descriptionLabel.layer.position = CGPointMake(kScreenSize.width/2, kScreenSize.width/2 + kScreenSize.width/5)
        
        maxLabel = UILabel(frame: CGRectMake(0, 0, 100, 40))
        maxLabel.textColor = UIColor.whiteColor()
        maxLabel.textAlignment = .Right // 最高気温を画面右に配置
        maxLabel.layer.position = CGPointMake(3 * kScreenSize.width/4, kScreenSize.width/2)
        maxLabel.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        
        minLabel = UILabel(frame: CGRectMake(0, 0, 100, 40))
        minLabel.textColor = UIColor.whiteColor()
        minLabel.textAlignment = .Left // 最低気温は画面左に配置
        minLabel.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        minLabel.layer.position = CGPointMake(kScreenSize.width/4, kScreenSize.width/2)
        
        refreshButton = UIBarButtonItem(image: UIImage(named: "arrow408"), style: .Plain, target: self, action: "refresh")
        refreshButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = refreshButton
        
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .White)
        indicatorView.layer.position = CGPointMake(kScreenSize.width/2, kScreenSize.height/2)
        indicatorView.color = UIColor.whiteColor()
        
        // self.view.addSubview()でviewに追加
        self.view.addSubview(backImageView)
        self.view.addSubview(tableView)
        self.view.addSubview(weatherImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(maxLabel)
        self.view.addSubview(minLabel)
        self.view.addSubview(indicatorView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        indicatorView.startAnimating()
        configureLocation()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelManager.sharedManager.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = WeatherTableViewCell(style: .Default, reuseIdentifier: "Cell")
        
        cell.dateLabel.text = ModelManager.sharedManager.list[indexPath.row].dt
        cell.minLabel.text = ModelManager.sharedManager.list[indexPath.row].min
        cell.maxLabel.text = ModelManager.sharedManager.list[indexPath.row].max
        cell.descriptionLabel.text = ModelManager.sharedManager.list[indexPath.row].aDescription
        cell.weatherImageView.image = UIImage(named:ModelManager.sharedManager.list[indexPath.row].main)?.imageWithRenderingMode(.AlwaysTemplate)
        
        return cell
    }
    
    func refresh(lat: Double, lng: Double){
        
        weak var weakSelf = self
        
        ModelManager.sharedManager.reloadWeather(lat, lng: lng, callback: { error in
            if error != nil {
                weakSelf?.indicatorView.stopAnimating()
                
                let alertVC = UIAlertController(title: "Error", message: "Failed to connect network.", preferredStyle: .Alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                weakSelf?.presentViewController(alertVC, animated: true, completion: nil)
            } else {
                self.indicatorView.stopAnimating()
                
                FCAnimation().performAnimation(weakSelf!.weatherImageView, duration: 1, delay: 0.3, type: .FadeIn)
                FCAnimation().performAnimation(weakSelf!.nameLabel, duration: 1, delay: 0, type: .FadeIn)
                FCAnimation().performAnimation(weakSelf!.maxLabel, duration: 1, delay: 0.3, type: .FadeIn)
                FCAnimation().performAnimation(weakSelf!.minLabel, duration: 1, delay: 0.3, type: .FadeIn)
                FCAnimation().performAnimation(weakSelf!.descriptionLabel, duration: 1, delay: 0.6, type: .FadeIn)
                
                weakSelf?.weatherImageView.image = UIImage(named: ModelManager.sharedManager.data.main)?.imageWithRenderingMode(.AlwaysTemplate)
                weakSelf?.nameLabel.text = ModelManager.sharedManager.data.name
                weakSelf?.descriptionLabel.text = ModelManager.sharedManager.data.aDescription
                weakSelf?.maxLabel.text = ModelManager.sharedManager.data.temp_max
                weakSelf?.minLabel.text = ModelManager.sharedManager.data.temp_min
            }
        })
        
        ModelManager.sharedManager.reloadDailyWeather(lat, lng: lng, callback: { error in
            if error != nil {
                
            } else {
                weakSelf?.tableView.reloadData()
            }
        })
    }
    
    func refresh() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var currentLocation: CLLocation? = locations.last as? CLLocation
        var lat: CLLocationDegrees? = currentLocation?.coordinate.latitude
        var lng: CLLocationDegrees? = currentLocation?.coordinate.longitude
        var dt: NSDate! = currentLocation?.timestamp
        
        if abs(dt.timeIntervalSinceNow) < 5.0 {
            refresh(lat!, lng: lng!)
            manager.stopUpdatingLocation()
        }
    }

    // 背景画像のタイマー発生時に呼び出されるメソッドchangeBack 3秒かけてフェードさせる
    func changeBack() {
        // 背景画像を配列で用意
        let backImages = [
            UIImage(named: "back0"),
            UIImage(named: "back1"),
            UIImage(named: "back2"),
            UIImage(named: "back3")
        ]
        
        let transition = CATransition()
        transition.duration = 3.0
        transition.type = kCATransitionFade
        backImageView.layer.addAnimation(transition, forKey: nil)
        backImageView.image = backImages[random() % backImages.count]
    }
    
    func configureLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        if self.locationManager.respondsToSelector("requestWhenInUseAuthorization") {
            self.locationManager.requestWhenInUseAuthorization()
            refresh()
        } else {
            refresh()
        }
    }
    
    deinit {
        tableView.dataSource = nil
        locationManager.delegate = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

