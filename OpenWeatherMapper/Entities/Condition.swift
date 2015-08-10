//
//  Condition.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/10.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

public enum GeneralCondition {
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

public enum MainCondition {
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


public struct Condition {
    
    public let id: Int
    public let general: GeneralCondition
    public let main: MainCondition
    
    internal init(id: Int, icon: String) {
        self.id = id
        
        if icon.hasPrefix("01") {
            general = GeneralCondition.Clear
            main = MainCondition.ClearSky
        } else if icon.hasPrefix("02") {
            general = GeneralCondition.Clear
            main = MainCondition.FewClouds
        } else if icon.hasPrefix("03") {
            general = GeneralCondition.Cloudy
            main = MainCondition.ScatteredClouds
        } else if icon.hasPrefix("04") {
            general = GeneralCondition.Cloudy
            main = MainCondition.BrokenClouds
        } else if icon.hasPrefix("09") {
            general = GeneralCondition.Rainy
            main = MainCondition.ShowerRain
        } else if icon.hasPrefix("10") {
            general = GeneralCondition.Rainy
            main = MainCondition.Rain
        } else if icon.hasPrefix("11") {
            general = GeneralCondition.Rainy
            main = MainCondition.Thunderstorm
        } else if icon.hasPrefix("13") {
            general = GeneralCondition.Snowy
            main = MainCondition.Snow
        } else if icon.hasPrefix("50") {
            general = GeneralCondition.Rainy
            main = MainCondition.Mist
        } else {
            general = GeneralCondition.Unknown
            main = MainCondition.Unknown
        }
    }
    
}
