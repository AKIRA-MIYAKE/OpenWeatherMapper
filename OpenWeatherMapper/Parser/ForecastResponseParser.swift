//
//  ForecastResponseParser.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/10.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import SwiftyJSON
import Result


public class ForecastResponseParser {
    
    public func parse(data: AnyObject) -> GetForecastResult {
        let json = JSON(data)
        
        
        let coordinate: Coordinate?
        if let lat = json["city"]["coord"]["lat"].double, let lon = json["city"]["coord"]["lon"].double {
            coordinate = Coordinate(latitude: lat, longitude: lon)
        } else {
            coordinate = nil
        }
        
        
        let city: City?
        if let id = json["city"]["id"].int,
            let name = json["city"]["name"].string,
            let country = json["city"]["country"].string
        {
            city = City(id: id, name: name, country: country)
        } else {
            city = nil
        }
        
        
        if let city = city, let coordinate = coordinate {
            
            if let list = json["list"].array {
                
                var weathers = [Weather]()
                
                for item in list {
                    
                    let date: NSDate?
                    if let dt = item["dt"].double {
                        date = NSDate(timeIntervalSince1970: dt)
                    } else {
                        date = nil
                    }
                    
                    
                    let temperatureMax: Temperature?
                    if let tempMax = item["main"]["temp_max"].double {
                        temperatureMax = Temperature(tempMax, degree: .Kelvin)
                    } else {
                        temperatureMax = nil
                    }
                    
                    let temperatureMin: Temperature?
                    if let tempMin = item["main"]["temp_min"].double {
                        temperatureMin = Temperature(tempMin, degree: .Kelvin)
                    } else {
                        temperatureMin = nil
                    }
                    
                    
                    let condition: Condition?
                    if let id = item["weather"][0]["id"].int, icon = item["weather"][0]["icon"].string {
                        condition = Condition(id: id, icon: icon)
                    } else {
                        condition = nil
                    }
                    
                    
                    if let condition = condition,
                        let temperatureMax = temperatureMax,
                        let temperatureMin = temperatureMin,
                        let date = date
                    {
                        let weather = Weather(
                            condition: condition,
                            temperatureMax: temperatureMax,
                            temperatureMin: temperatureMin,
                            city: city,
                            coordinate: coordinate,
                            date: date)
                        
                        weathers.append(weather)
                    }
                    
                }
                
                return GetForecastResult.Success(weathers)
                
            } else {
                let error = NSError(domain: ErrorDomain, code: ErrorCode.ParseError.rawValue, userInfo: nil)
                return GetForecastResult.Failure(error)
            }
            
        } else {
            let error = NSError(domain: ErrorDomain, code: ErrorCode.ParseError.rawValue, userInfo: nil)
            return GetForecastResult.Failure(error)
        }
    }
    
}