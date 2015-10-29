//
//  GetDailyForecastRequest.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/10/27.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import Result
import SwiftyJSON


public class GetDailyForecastRequest: Request {
    
    // MARK: - Typealias
    
    public typealias Forecast = [Weather]
    public typealias Entity = Forecast
    
    
    // MARK: - Variables
    
    public private (set) var method: String = "GET"
    public private (set) var path: String = "/data/2.5/forecast/daily"
    public var parameters: [String: AnyObject]
    
    
    // MARK: - Initialize
    
    public init(cityName: String, count: Int) {
        self.parameters = ["q": cityName, "cnt": count]
    }
    
    public init(cityName: String, countryCode: String, count: Int) {
        self.parameters = ["q": "\(cityName),\(countryCode)", "cnt": count]
    }
    
    public init(cityId: Int, count: Int) {
        self.parameters = ["id": cityId, "cnt": count]
    }
    
    public init(_ coordinate: Coordinate, count: Int) {
        self.parameters = ["lat": coordinate.latitude, "lon": coordinate.longitude, "cnt": count]
    }
    
    
    // MARK: - Method
    
    public func parse(data: AnyObject) -> Entity? {
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
                var forecast = [Weather]()
                
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
                    
                    let temperatures: Temperatures?
                    if let max = temperatureMax, let min = temperatureMin {
                        temperatures = Temperatures(maximum: max, minimum: min)
                    } else {
                        temperatures = nil
                    }
                    
                    
                    let condition: Condition?
                    if let id = item["weather"][0]["id"].int,
                        description = item["weather"][0]["description"].string {
                            condition = Condition(id: id, description: description)
                    } else {
                        condition = nil
                    }
                    
                    
                    if let condition = condition, let temperatures = temperatures, let date = date {
                        let weather = Weather(condition: condition, temperatures: temperatures, city: city, coordinate: coordinate, date: date)
                        forecast.append(weather)
                    }
                    
                }
                
                return forecast
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
}
