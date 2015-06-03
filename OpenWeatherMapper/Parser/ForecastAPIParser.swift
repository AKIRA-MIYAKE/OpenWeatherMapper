//
//  ForecastAPIParser.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result

class ForecastAPIParser: ParserProtocol {
    
    typealias Value = [Weather]
    
    func parse(data: AnyObject) -> Result<Value, NSError> {
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
        var forecast = [Weather]()
        
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
                let temperature: Temperature?
                
                if let temp = item["main"]["temp"].double {
                    temperature = Temperature(kelvin: temp)
                } else {
                    temperature = nil
                }
                
                /* Condition */
                let condition: Condition?
                
                if let id = item["weather"][0]["id"].int, let icon = item["weather"][0]["icon"].string {
                    condition = Condition(id: id, icon: icon)
                } else {
                    condition = nil
                }
                
                /* Weather */
                if let temperature = temperature,
                    let condition = condition,
                    let date = date {
                        let weather = Weather(
                            condition: condition,
                            temperature: temperature,
                            place: place,
                            coordinate: coordinate,
                            date: date)
                        
                        forecast.append(weather)
                }
            }
            
            return Result.success(forecast)
        } else {
            let error = NSError(domain: Const.errorDomain, code: Const.ErrorCode.ParseError.rawValue, userInfo: nil)
            return Result.failure(error)
        }
    }
    
}