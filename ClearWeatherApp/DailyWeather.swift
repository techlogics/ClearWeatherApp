//
//  DailyWeather.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 2/21/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class DailyWeather: NSObject {
   
    var aDescription:String = ""
    var temp_min:String = ""
    var temp_max:String = ""
    var main:String = ""
    var dt:String = ""
    
    //@引数  => UnixTime:Double
    //@返り値  => 月 + 日付の文字列:String
    func TranslateUnixTime(UnixTimedata:Double) -> String {
        let data = NSDate(timeIntervalSince1970: UnixTimedata)
        return TranslateUnixTimeAtMonth(data) + TranslateUnixTimeAtDay(data)
    }
    
    //UnixTimeから月を求める関数
    func TranslateUnixTimeAtMonth(data:NSDate) ->String{
        var outPutFormat = NSDateFormatter()
        outPutFormat.locale = NSLocale(localeIdentifier: "ja_JP")
        outPutFormat.dateFormat = "MM"
        return outPutFormat.stringFromDate(data)
    }
    
    //UninxTimeから日付を求める関数
    func TranslateUnixTimeAtDay(data:NSDate) ->String{
        var outPutFormat = NSDateFormatter()
        outPutFormat.locale = NSLocale(localeIdentifier: "ja_JP")
        outPutFormat.dateFormat = "dd"
        return outPutFormat.stringFromDate(data)
    }
}
