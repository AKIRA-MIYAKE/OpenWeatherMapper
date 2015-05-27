//
//  Temperature.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public struct Temperature {
    
    public enum Degree {
        case Kelvin
        case Celsius
        case Fahrenheit
        
        func toString() -> String {
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
    
    
    public let kelvin: Double
    public let celsius: Double
    public let fahrenheit: Double
    
    public init(kelvin: Double) {
        self.kelvin = kelvin
        
        self.celsius = kelvin - 273.15
        self.fahrenheit = kelvin * 9 / 5 - 459.67
    }
    
    public init(celsius: Double) {
        self.celsius = celsius
        
        self.kelvin = celsius + 273.15
        self.fahrenheit = celsius * 9 / 5 + 32
    }
    
    public init(fahrenheit: Double) {
        self.fahrenheit = fahrenheit
        
        self.kelvin = fahrenheit * 5 / 9 + 459.67
        self.celsius = fahrenheit * 5 / 9 - 32
    }
    
}
