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
    public let temperature: Temperature
    public let place: Place
    public let coordinate: Coordinate
    public let date: NSDate
    
}
