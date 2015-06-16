//
//  DailyForecast.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/06/16.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public struct DailyWeather {
    
    // MARK: - let
    
    public let condition: Condition
    public let maxTemperature: Temperature
    public let minTemperature: Temperature
    public let place: Place
    public let coordinate: Coordinate
    public let date: NSDate
    
    
    // MARK: - Initialize
    
    public init(condition: Condition, maxTemperature: Temperature, minTemperature: Temperature, place: Place, coordinate: Coordinate, date: NSDate) {
        self.condition = condition
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.place = place
        self.coordinate = coordinate
        self.date = date
    }
    
}