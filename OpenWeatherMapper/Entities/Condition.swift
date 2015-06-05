//
//  Condition.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public struct Condition {
    
    public enum General: String {
        case Unknown = "Unknown"
        case Clear = "Clear"
        case Cloudy = "Cloudy"
        case Rainy = "Rainy"
        case Snowy = "Snowy"
        
        public func toString() -> String {
            return self.rawValue
        }
    }
    
    public enum Main: String {
        case Unknown = "Unknown"
        case ClearSky = "Clear Sky"
        case FewClouds = "Few Clouds"
        case ScatteredClouds = "Scattered Clunds"
        case BrokenClouds = "Broken Crounds"
        case ShowerRain = "Shower Rain"
        case Rain = "Rain"
        case Thunderstorm = "Thnderstorm"
        case Snow = "Snow"
        case Mist = "Mist"
        
        public func toString() -> String {
            return self.rawValue
        }
    }
    
    
    let id: Int
    let icon: String
    
    public var general: General {
        get {
            switch main {
            case .Unknown:
                return General.Unknown
            case .ClearSky, .FewClouds:
                return General.Clear
            case .BrokenClouds, .ScatteredClouds:
                return General.Cloudy
            case .ShowerRain, .Rain, .Thunderstorm, .Mist:
                return General.Rainy
            case .Snow:
                return General.Snowy
            }
        }
    }
    
    public var main: Main {
        get {
            if icon.hasPrefix("01") {
                return Main.ClearSky
            } else if icon.hasPrefix("02") {
                return Main.FewClouds
            } else if icon.hasPrefix("03") {
                return Main.ScatteredClouds
            } else if icon.hasPrefix("04") {
                return Main.BrokenClouds
            } else if icon.hasPrefix("09") {
                return Main.ShowerRain
            } else if icon.hasPrefix("10") {
                return Main.Rain
            } else if icon.hasPrefix("11") {
                return Main.Thunderstorm
            } else if icon.hasPrefix("13") {
                return Main.Snow
            } else if icon.hasPrefix("50") {
                return Main.Mist
            } else {
                return Main.Unknown
            }
        }
    }
    
}
