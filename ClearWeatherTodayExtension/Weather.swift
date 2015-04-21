//
//  Weather.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 2/21/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class Weather: NSObject {
    
    // Swiftには型推論と呼ばれる型を自動で判別する機能があるので型を明示しなくてもだいじょうぶ！
    // var name: String = String() ではなく var name = String() でだいじょうぶ！
    var aDescription = String()
    var name = String()
    var temp_max = String()
    var temp_min = String()
    var main = String()
    
    // ここはインスタンスメソッドではなくクラスメソッドで "func" の前に "class" をつける
    // また今回は通信用のライブラリの関係で"NSDictionary"で受け取るのではなく、"AnyObject"と呼ばれる汎用型で受け取る。
    class func parseJSON(data: AnyObject?) -> Weather {
        let weather = Weather()
        // jsonのパースはOptionalを考慮してこのように安全に取り出す
        // if let文はOptionalのアンラップ構文
        // 以前のとり方だと値が返ってこなかった時にクラッシュしてしまう
        if let weatherData = data as? NSDictionary {
            if let
                name = weatherData["name"] as? String,
                weatherArray = weatherData["weather"] as? NSArray,
                main = weatherData["main"] as? NSDictionary {
                    weather.name = name
                    
                if let
                    temp_max = main["temp_max"] as? Double,
                    temp_min = main["temp_min"] as? Double,
                    main = weatherArray[0]["main"] as? String,
                    aDescription = weatherArray[0]["description"] as? String {
                        weather.temp_max = translateDouble(temp_max)
                        weather.temp_min = translateDouble(temp_min)
                        weather.main = main
                        weather.aDescription = aDescription
                }
            }
        }
        return weather
    }
    
    class func translateDouble(doubleValue: Double) -> String {
        let ud = NSUserDefaults(suiteName: "group.clearWeather")
        if ud!.boolForKey("CorF") {
            return NSString(format: "%1.0f°", floor(doubleValue - 273.15)) as String
        }
        return NSString(format: "%1.0f°", floor(1.8 * (doubleValue - 273.15) + 32)) as String
    }
    
    func translateString(StringValue: String) -> Double {
        return atof(StringValue)
    }
    
}
