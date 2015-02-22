//
//  Weather.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 2/21/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class Weather: NSObject {
    
    var aDiscription:String = ""
    var temp_min:String = ""
    var temp_max:String = ""
    var main:String = ""
    var name:String = ""
    
    func perseJSON(data:NSDictionary) -> Weather {
        var weather:Weather = Weather()
        weather.aDiscription = data.valueForKeyPath("weather.discription") as String
        weather.temp_min = self.translateDouble(data.valueForKeyPath("main.temp_min") as Double)
        weather.temp_max = self.translateDouble(data.valueForKeyPath("main.temp_max") as Double)
        weather.main = data.valueForKeyPath("weather.main") as String
        weather.name = data.valueForKey("name") as String
        return weather
    }
    
    func translateDouble(doubleValue:Double) -> String {
        return NSString(format: "%1.0f゜", floor(doubleValue - 273.15))
    }
    func translateString(StringValue:String) -> Double {
        return atof(StringValue)
    }
    
}
