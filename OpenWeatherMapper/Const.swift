//
//  Const.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/06/03.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public struct Const {
    
    public static let baseURLString = "http://api.openweathermap.org/data/2.5/"
    public static let weatherAPIPath = "weather"
    public static let forecastAPIPath = "forecast"
    public static let dailyForecastAPIPath = "forecast/daily"
    
    public static let errorDomain = "com.dream-of-electric-cat.OpenWeatherMapper"
    
    public enum ErrorCode: Int {
        case Unknown = 0
        case ParseError
    }
    
}