//
//  Condition.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public struct Condition {
    
    public enum General {
        case Unknown
        case Clear
        case Cloudy
        case Rainy
        case Snowy
    }
    
    public enum Main {
        case Unknown
        case ClearSky
        case FewClouds
        case ScatteredClouds
        case BrokenClouds
        case ShowerRain
        case Rain
        case Thunderstorm
        case Snow
        case Mist
        
        func toString() -> String {
            switch self {
            case .Unknown:
                return "Unknown"
            case .ClearSky:
                return "Clear Sky"
            case .FewClouds:
                return "Few Clouds"
            case .ScatteredClouds:
                return "Scattered Clouds"
            case .BrokenClouds:
                return "Broken Clouds"
            case .ShowerRain:
                return "Shower Rain"
            case .Rain:
                return "Rain"
            case .Thunderstorm:
                return "Thunderstorm"
            case .Snow:
                return "Snow"
            case .Mist:
                return "Mist"
            }
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
