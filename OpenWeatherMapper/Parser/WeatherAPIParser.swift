//
//  WeatherAPIParser.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result

class WeatherAPIParser: ParserProtocol {
    
    typealias ResultType = WeatherAPIResult
    
    func parse(data: AnyObject) -> ResultType {
        let json = JSON(data)
        
        /* Date */
        let date: NSDate?
        
        if let dt = json["dt"].double {
            date = NSDate(timeIntervalSince1970: dt)
        } else {
            date = nil
        }
        
        /* Coordinate */
        let coordinate: Coordinate?
        
        if let lat = json["coord"]["lat"].double, let lon = json["coord"]["lon"].double {
            coordinate = Coordinate(latitude: lat, longitude: lon)
        } else {
            coordinate = nil
        }
        
        /* Temperature */
        let temperature: Temperature?
        
        if let temp = json["main"]["temp"].double {
            temperature = Temperature(kelvin: temp)
        } else {
            temperature = nil
        }
        
        /* Condition */
        let condition: Condition?
        
        if let id = json["weather"][0]["id"].int, let icon = json["weather"][0]["icon"].string {
            condition = Condition(id: id, icon: icon)
        } else {
            condition = nil
        }
        
        /* Place */
        let place: Place?
        
        if let id = json["id"].int,
            let name = json["name"].string,
            let country = json["sys"]["country"].string
        {
            place = Place(id: id, city: name, country: country)
        } else {
            place = nil
        }
        
        
        let weather: Weather?
        
        if let condition = condition,
            let temperature = temperature,
            let place = place,
            let coordinate = coordinate,
            let date = date
        {
            weather = Weather(condition: condition,
                temperature: temperature,
                place: place,
                coordinate: coordinate,
                date: date)
        } else {
            weather = nil
        }
        
        
        if let weather = weather {
            return ResultType(value: weather)
        } else {
            let error = NSError(
                domain: Const.errorDomain,
                code: Const.ErrorCode.ParseError.rawValue,
                userInfo: nil)
            
            return ResultType(error: error)
        }
    }
    
}
