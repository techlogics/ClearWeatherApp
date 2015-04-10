//
//  ModelManager.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 4/9/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class ModelManager: NSObject {
    
    var list = [DailyWeather]()
    var data = Weather()
    
    class var sharedManager: ModelManager {
        struct Static {
            static let client: ModelManager = ModelManager()
        }
        return Static.client
    }
    
    func reloadDailyWeather(lat: Double, lng: Double, callback: (NSError?) -> ()) {
        weak var weakSelf = self
        OpenWeatherAPIClient.sharedClient.getDailyWeather(lat, lng: lng, callback: { list, error in
            weakSelf?.list = list
            callback(error)
        })
    }
    
    func reloadWeather(lat: Double, lng: Double, callback: (NSError?) -> ()) {
        weak var weakSelf = self
        OpenWeatherAPIClient.sharedClient.getWeather(lat, lng: lng, callback: { data, error in
            weakSelf?.data = data
            callback(error)
        })
    }
}
