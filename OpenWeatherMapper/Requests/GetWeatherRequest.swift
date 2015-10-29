//
//  GetCurrentWeatherRequest.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/10/26.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import Result
import SwiftyJSON


public class GetWeatherRequest: Request {
    
    // MARK: - Typealias
    
    public typealias Entity = Weather
    
    
    // MARK: - Variables
    
    public private (set) var method: String = "GET"
    public private (set) var path: String = "/data/2.5/weather"
    public var parameters: [String: AnyObject]
    
    
    // MARK: - Initialize
    
    public init(cityName: String) {
        self.parameters = ["q": cityName]
    }
    
    public init(cityName: String, countryCode: String) {
        self.parameters = ["q": "\(cityName),\(countryCode)"]
    }
    
    public init(cityId: Int) {
        self.parameters = ["id": cityId]
    }
    
    public init(_ coordinate: Coordinate) {
        self.parameters = ["lat": coordinate.latitude, "lon": coordinate.longitude]
    }
    
    
    // MARK: - Method
    
    public func parse(data: AnyObject) -> Entity? {
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
        
        
        let temperatures: Temperatures?
        if let max = temperatureMax, let min = temperatureMin {
            temperatures = Temperatures(maximum: max, minimum: min)
        } else {
            temperatures = nil
        }
        
        
        let conditon: Condition?
        if let id = json["weather"][0]["id"].int,
            let description = json["weather"][0]["description"].string {
                conditon = Condition(id: id, description: description)
        } else {
            conditon = nil
        }
        
        
        let weather: Weather?
        if let condition = conditon, let temperatures = temperatures, let city = city, let coordinate = coordinate, let date = date {
            weather = Weather(condition: condition, temperatures: temperatures, city: city, coordinate: coordinate, date: date)
        } else {
            weather = nil
        }
        
        
        return weather
    }
    
}
