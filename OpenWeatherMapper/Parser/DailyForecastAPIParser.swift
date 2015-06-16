//
//  DailyForecastAPIParser.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/06/16.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result

public class DailyForecastAPIParser: ParserProtocol {
    
    typealias ResultType = DailyForecastAPIResult
    
    func parse(data: AnyObject) -> ResultType {
        let json = JSON(data)
        
        /* Coordinate */
        let coordinate: Coordinate?
        
        if let lat = json["city"]["coord"]["lat"].double, let lon = json["city"]["coord"]["lon"].double {
            coordinate = Coordinate(latitude: lat, longitude: lon)
        } else {
            coordinate = nil
        }
        
        
        /* Place */
        let place: Place?
        
        if let id = json["city"]["id"].int,
            let name = json["city"]["name"].string,
            let country = json["city"]["country"].string {
                place = Place(id: id, city: name, country: country)
        } else {
            place = nil
        }
        
        
        /* Forecast */
        var dailyForecast = [DailyWeather]()
        
        if let coordinate = coordinate, let place = place, let list = json["list"].array {
            for item in list {
                /* Date */
                let date: NSDate?
                
                if let dt = item["dt"].double {
                    date = NSDate(timeIntervalSince1970: dt)
                } else {
                    date = nil
                }
                
                
                /* Temperature */
                let maxTemperature: Temperature?
                
                if let maxTemp = item["temp"]["max"].double {
                    maxTemperature = Temperature(kelvin: maxTemp)
                } else {
                    maxTemperature = nil
                }
                
                let minTemperature: Temperature?
                
                if let minTemp = item["temp"]["min"].double {
                    minTemperature = Temperature(kelvin: minTemp)
                } else {
                    minTemperature = nil
                }
                
                
                /* Condition */
                let condition: Condition?
                
                if let id = item["weather"][0]["id"].int, let icon = item["weather"][0]["icon"].string {
                    condition = Condition(id: id, icon: icon)
                } else {
                    condition = nil
                }
                
                
                /* Daily Weather */
                if let maxTemperature = maxTemperature,
                    let minTemperature = minTemperature,
                    let condition = condition,
                    let date = date {
                        let dailyWeather = DailyWeather(
                            condition: condition,
                            maxTemperature: maxTemperature,
                            minTemperature: minTemperature,
                            place: place,
                            coordinate: coordinate,
                            date: date)
                        
                        dailyForecast.append(dailyWeather)
                }
            }
            
            return ResultType.success(dailyForecast)
        } else {
            let error = NSError(
                domain: Const.errorDomain,
                code: Const.ErrorCode.ParseError.rawValue,
                userInfo: nil)
            
            return ResultType(error: error)
        }
    }
    
}