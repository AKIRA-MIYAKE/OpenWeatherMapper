//
//  WeatherResponseParser.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/10.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import SwiftyJSON
import Result


public class WeatherResponseParser {
    
    public func parse(data: AnyObject) -> GetWeatherResult {
        let json = JSON(data)
        
        
        let date: NSDate?
        if let dt = json["dt"].double {
            date = NSDate(timeIntervalSince1970: dt)
        } else {
            date = nil
        }
        
        
        let coordinate: Coordinate?
        if let lat = json["coord"]["lat"].double, let lon = json["coord"]["lon"].double {
            coordinate = Coordinate(latitude: lat, longitude: lon)
        } else {
            coordinate = nil
        }
        
        
        let city: City?
        if let id = json["id"].int,
            let name = json["name"].string,
            let country = json["sys"]["country"].string
        {
            city = City(id: id, name: name, country: country)
        } else {
            city = nil
        }
        
        
        let temperatureMax: Temperature?
        if let tempMax = json["main"]["temp_max"].double {
            temperatureMax = Temperature(tempMax, degree: .Kelvin)
        } else {
            temperatureMax = nil
        }
        
        let temperatureMin: Temperature?
        if let tempMin = json["main"]["temp_max"].double {
            temperatureMin = Temperature(tempMin, degree: .Kelvin)
        } else {
            temperatureMin = nil
        }
        
        
        let conditon: Condition?
        if let id = json["weather"][0]["id"].int, let icon = json["weather"][0]["icon"].string {
            conditon = Condition(id: id, icon: icon)
        } else {
            conditon = nil
        }
        
        
        if let condition = conditon,
            let temperatureMax = temperatureMax,
            let temperatureMin = temperatureMin,
            let city = city,
            let coordinate = coordinate,
            let date = date
        {
            let weather = Weather(
                condition: condition,
                temperatureMax: temperatureMax,
                temperatureMin: temperatureMin,
                city: city, coordinate:
                coordinate, date: date)
            return GetWeatherResult.Success(weather)
        } else {
            let error = NSError(domain: ErrorDomain, code: ErrorCode.ParseError.rawValue, userInfo: nil)
            return GetWeatherResult.Failure(error)
        }
    }
    
}