//
//  Weather.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation


public struct Weather {
    
    // MARK: - let
    
    public let condition: Condition
    public let temperatureMax: Temperature
    public let temperatureMin: Temperature
    public let city: City
    public let coordinate: Coordinate
    public let date: NSDate
    
    
    // MARK: - Variables
    
    public var temperature: Temperature {
        get {
            let value = (temperatureMax.get(degree: .Kelvin) + temperatureMin.get(degree: .Kelvin)) / 2
            return Temperature(value, degree: .Kelvin)
        }
    }
    
    
    // MARK: - Initialize
    
    public init(
        condition: Condition,
        temperatureMax: Temperature,
        temperatureMin: Temperature,
        city: City,
        coordinate: Coordinate,
        date: NSDate)
    {
        self.condition = condition
        self.temperatureMax = temperatureMax
        self.temperatureMin = temperatureMin
        self.city = city
        self.coordinate = coordinate
        self.date = date
    }
    
}
