//
//  Temperature.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/10.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

public struct Temperature {
    
    public enum Degree {
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
    
    
    // MARK: - let
    
    private let rawValue: Double
    
    
    // MARK: - Initialize
    
    public init(_ value: Double, degree: Degree) {
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
    
    public func get(#degree: Degree) -> Double {
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