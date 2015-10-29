//
//  Temperature.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/10/27.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

public enum TemperatureDegree {
    case Kelvin
    case Celsius
    case Fahrenheit
}


public struct Temperature {
    
    private let rawValue: Double
    
    public init(_ value: Double, degree: TemperatureDegree) {
        switch degree {
        case .Kelvin:
            self.rawValue = value
        case .Celsius:
            self.rawValue = value + 273.15
        case .Fahrenheit:
            self.rawValue = value * 5 / 9 + 459.67
        }
    }
    
    public func get(degree degree: TemperatureDegree) -> Double {
        switch degree {
        case .Kelvin:
            return rawValue
        case .Celsius:
            return rawValue - 273.15
        case .Fahrenheit:
            return rawValue * 9 / 5 - 459.67
        }
    }
    
}


public struct Temperatures {
    
    public let maximum: Temperature
    public let minimum: Temperature
    
    public var average: Temperature {
        return Temperature((maximum.get(degree: .Kelvin) + minimum.get(degree: .Kelvin)) / 2, degree: .Kelvin)
    }
    
    public init(maximum: Temperature, minimum: Temperature) {
        self.maximum = maximum
        self.minimum = minimum
    }
    
}
