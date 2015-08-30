//
//  DailyForecastResponseParser.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/10.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import SwiftyJSON
import Result


public class DailyForecastResponseParser {
    
    public func parse(data: AnyObject) -> GetDailyForecastResult {
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
                    if let tempMax = item["temp"]["max"].double {
                        temperatureMax = Temperature(tempMax, degree: .Kelvin)
                    } else {
                        temperatureMax = nil
                    }
                    
                    let temperatureMin: Temperature?
                    if let tempMin = item["temp"]["min"].double {
                        temperatureMin = Temperature(tempMin, degree: .Kelvin)
                    } else {
                        temperatureMin = nil
                    }
                    
                    
                    let condition: Condition?
                    if let id = item["weather"][0]["id"].int,
                        description = item["weather"][0]["description"].string {
                        condition = Condition(id: id, description: description)
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
                
                return GetDailyForecastResult.Success(weathers)
                
            } else {
                let error = OpenWeatherMapperError.ParseError(data)
                return GetDailyForecastResult.Failure(error)
            }
            
        } else {
            let error = OpenWeatherMapperError.ParseError(data)
            return GetDailyForecastResult.Failure(error)
        }
    }
    
}