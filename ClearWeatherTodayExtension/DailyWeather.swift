//
//  DailyWeather.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 2/21/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class DailyWeather: NSObject {
    
    var aDescription = String()
    var min = String()
    var max = String()
    var main = String()
    var dt = String()
    
    var name = String()
    
    class func parseJSON(data: AnyObject?) -> [DailyWeather] {
        var dailyWeather = [DailyWeather]()
        
        if let weatherData = data as? NSDictionary {
            if let list = weatherData["list"] as? NSArray {
                for lst in list {
                    let weather = DailyWeather()
                    
                    if let
                        weatherArray = lst["weather"] as? NSArray,
                        dt = lst["dt"] as? NSTimeInterval,
                        temp = lst["temp"] as? NSDictionary
                    {
                        weather.dt = translateTime(dt)
                        
                        if let
                            aDescription = weatherArray[0]["description"] as? String,
                            main = weatherArray[0]["main"] as? String,
                            temp_min = temp["min"] as? Double,
                            temp_max = temp["max"] as? Double
                        {
                                weather.aDescription = aDescription
                                weather.main = main
                                weather.min = translateDouble(temp_min)
                                weather.max = translateDouble(temp_max)
                        }
                    }
                    if let city = weatherData["city"] as? NSDictionary {
                        if let name = city["name"] as? String {
                            weather.name = name
                        }
                    }
                    dailyWeather.append(weather)
                }
            }
        }
        return dailyWeather
    }
    
    // 時間の直し方わからなかったのでググりました。あってるかわかりませんm(_ _)m
    private class func translateTime(unixDate: NSTimeInterval) -> String {
        
        let dateComp: NSDateComponents = NSCalendar.currentCalendar().components(.CalendarUnitDay | .CalendarUnitMonth, fromDate: NSDate(timeIntervalSince1970: unixDate))
        return "\(dateComp.month)/\(dateComp.day)"
    }
    
    class func translateDouble(doubleValue:Double) -> String {
        let ud = NSUserDefaults(suiteName: "group.clearWeather")
        if ud!.boolForKey("CorF") {
            return NSString(format: "%1.0f°", floor(doubleValue)) as String
        }
        return NSString(format: "%1.0f°", floor((9 / 5 * doubleValue) + 32)) as String
    }
}
