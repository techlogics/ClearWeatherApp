//
//  DailyWeather.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 2/21/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class DailyWeather: NSObject {
    
    var aDiscription:String = ""
    var temp_min:String = ""
    var temp_max:String = ""
    var main:String = ""
    var dt:String = ""
    
    func perseJSON(data:NSDictionary) -> NSArray {
        var list = data.valueForKey("list") as NSArray
        var weatherData:NSMutableArray!
        
        for lists in list {
            var weather:DailyWeather = DailyWeather()
            weather.aDiscription = lists.valueForKeyPath("weather.discription") as String
            weather.temp_min = self.translateDouble(lists.valueForKeyPath("weather.temp_min") as Double)
            weather.temp_max = self.translateDouble(lists.valueForKeyPath("weather.temp_max") as Double)
            weather.main = lists.valueForKeyPath("weather.main") as String
            weather.dt = self.translateTime(lists.valueForKey("dt") as NSTimeInterval)
            weatherData.addObject(weather)
        }
        return weatherData
    }
    
    func translateTime(unixDate:NSTimeInterval) -> String {
        var date = NSDate(timeIntervalSince1970: unixDate)
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.stringFromDate(date) as NSString
    }
    
    func translateDouble(doubleValue:Double) -> String {
        return NSString(format: "%1.0f゜", floor(doubleValue - 273.15))
    }
}
