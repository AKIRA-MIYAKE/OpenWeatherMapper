//
//  Weather.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation


public struct Weather {
    
    public let condition: Condition
    public let temperature: (max: Temperature, min: Temperature)
    public let city: City
    public let coordinate: Coordinate
    public let date: NSDate
    
    internal init(
        condition: Condition,
        temperature: (max: Temperature, min: Temperature),
        city: City,
        coordinate: Coordinate,
        date: NSDate)
    {
        self.condition = condition
        self.temperature = temperature
        self.city = city
        self.coordinate = coordinate
        self.date = date
    }
    
}
