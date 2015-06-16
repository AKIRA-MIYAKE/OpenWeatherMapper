//
//  Const.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/06/03.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

struct Const {
    
    static let baseURLString = "http://api.openweathermap.org/data/2.5/"
    static let weatherAPIPath = "weather"
    static let forecastAPIPath = "forecast"
    static let dailyForecastAPIPath = "forecast/daily"
    
    static let errorDomain = "com.dream-of-electric-cat.OpenWeatherMapper"
    
    enum ErrorCode: Int {
        case Unknown = 0
        case ParseError
    }
    
}