//
//  Condition.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/10.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

public struct Condition {
    
    public enum General {
        case Unknown
        case Clear
        case Cloudy
        case Rainy
        case Snowy
        
        public func toString() -> String {
            switch self {
            case .Unknown:
                return "Unknown"
            case .Clear:
                return "Clear"
            case .Cloudy:
                return "Cloudy"
            case .Rainy:
                return "Rainy"
            case .Snowy:
                return "Snowy"
            }
        }
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
        
        public func toString() -> String {
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
    
    
    // MARK: - let
    
    public let id: Int
    public let general: General
    public let main: Main
    
    
    // MARK: - Initialize
    
    internal init(id: Int, icon: String) {
        self.id = id
        
        if icon.hasPrefix("01") {
            general = General.Clear
            main = Main.ClearSky
        } else if icon.hasPrefix("02") {
            general = General.Clear
            main = Main.FewClouds
        } else if icon.hasPrefix("03") {
            general = General.Cloudy
            main = Main.ScatteredClouds
        } else if icon.hasPrefix("04") {
            general = General.Cloudy
            main = Main.BrokenClouds
        } else if icon.hasPrefix("09") {
            general = General.Rainy
            main = Main.ShowerRain
        } else if icon.hasPrefix("10") {
            general = General.Rainy
            main = Main.Rain
        } else if icon.hasPrefix("11") {
            general = General.Rainy
            main = Main.Thunderstorm
        } else if icon.hasPrefix("13") {
            general = General.Snowy
            main = Main.Snow
        } else if icon.hasPrefix("50") {
            general = General.Rainy
            main = Main.Mist
        } else {
            general = General.Unknown
            main = Main.Unknown
        }
    }
    
}
