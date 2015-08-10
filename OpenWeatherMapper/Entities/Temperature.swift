//
//  Temperature.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/10.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

public enum TemperatureDegree {
    
    case Kelvin
    case Celsius
    case Fahrenheit
    
    public func toString() -> String {
        switch self {
        case .Kelvin:
            return "Kelvin"
        case .Celsius:
            return "Celsius"
        case .Fahrenheit:
            return "Fahrenheit"
        }
    }
    
    public func toDisplayString() -> String {
        switch self {
        case .Kelvin:
            return "K"
        case .Celsius:
            return "°"
        case .Fahrenheit:
            return "°"
        }
    }
    
}

public struct Temperature {
    
    // MARK: - let
    
    private let rawValue: Double
    
    
    // MARK: - Initialize
    
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
    
    
    // MARK: - Method
    
    public func get(#degree: TemperatureDegree) -> Double {
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