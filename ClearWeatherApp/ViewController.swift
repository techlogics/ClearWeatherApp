//
//  ViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 2/21/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView!
    var weatherImageView: UIImageView!
    var descriptionLabel: UILabel!
    var minLabel: UILabel!
    var maxLabel: UILabel!
    var nameLabel: UILabel!
    
    var weatherArray = [DailyWeather]()
    
    override func loadView() {
        super.loadView()
        
        // TableViewのsizeはデバイスの大きさに合わせる↓
        let kScreenSize = UIScreen.mainScreen().bounds.size
        
        // TableViewの配置は画面の下半分に設定
        tableView = UITableView(frame: CGRectMake(0, kScreenSize.height/2, kScreenSize.width, kScreenSize.height/2))
        tableView.backgroundColor = UIColor.orangeColor()
        tableView.rowHeight = 100
        tableView.dataSource = self
        self.tableView.separatorStyle = .None
        
        // それぞれのパーツ CGRectMakeでパーツの大きさを設定 CGPointMakeで配置位置を設定
        weatherImageView = UIImageView(frame: CGRectMake(0, 0, kScreenSize.width/3, kScreenSize.width/3))
        weatherImageView.tintColor = UIColor.whiteColor()
        weatherImageView.layer.position = CGPointMake(kScreenSize.width/2, kScreenSize.width/2)
        
        nameLabel = UILabel(frame: CGRectMake(0, 0, 200, 40))
        nameLabel.textColor =  UIColor.whiteColor()
        nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        nameLabel.textAlignment = .Center
        nameLabel.layer.position = CGPointMake(kScreenSize.width/2, kScreenSize.width/2 - kScreenSize.width/5)
        
        descriptionLabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
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
        
        // self.view.addSubview()でviewに追加
        self.view.addSubview(tableView)
        self.view.addSubview(weatherImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(maxLabel)
        self.view.addSubview(minLabel)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        OpenWeatherAPIClient.sharedClient.getWeather({data, error in
            
            let weather: Weather = data
            self.weatherImageView.image = UIImage(named: weather.main)?.imageWithRenderingMode(.AlwaysTemplate)
            self.nameLabel.text = weather.name
            self.descriptionLabel.text = weather.aDescription
            self.maxLabel.text = weather.temp_max
            self.minLabel.text = weather.temp_min
            
        })
        
        
        OpenWeatherAPIClient.sharedClient.getDailyWeather({data, error in
            self.weatherArray = data
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = WeatherTableViewCell(style: .Default, reuseIdentifier: "Cell")
        updateCell(cell, indexPath: indexPath)
        return cell
    }
    
    func updateCell(cell: WeatherTableViewCell, indexPath: NSIndexPath) {
        cell.dateLabel.text = weatherArray[indexPath.row].dt
        cell.minLabel.text = weatherArray[indexPath.row].min
        cell.maxLabel.text = weatherArray[indexPath.row].max
        cell.descriptionLabel.text = weatherArray[indexPath.row].aDescription
        cell.weatherImageView.image = UIImage(named:weatherArray[indexPath.row].main)?.imageWithRenderingMode(.AlwaysTemplate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

