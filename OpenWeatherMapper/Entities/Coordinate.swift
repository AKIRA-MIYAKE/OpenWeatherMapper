//
//  Coordinate.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public struct Coordinate: Hashable {
    
    public let latitude: Double
    public let longitude: Double
    
    public var hashValue: Int {
        return Int(latitude * longitude)
    }
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

public func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
