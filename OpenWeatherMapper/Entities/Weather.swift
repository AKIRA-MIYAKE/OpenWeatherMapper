//
//  Weather.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/10/26.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public struct Weather {
    
    public let condition: Condition
    public let temperatures: Temperatures
    public let city: City
    public let coordinate: Coordinate
    public let date: NSDate
    
    public init(condition: Condition, temperatures: Temperatures, city: City, coordinate: Coordinate, date: NSDate) {
        self.condition = condition
        self.temperatures = temperatures
        self.city = city
        self.coordinate = coordinate
        self.date = date
    }
    
}