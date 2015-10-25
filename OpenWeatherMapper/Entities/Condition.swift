//
//  Condition.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/10/27.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

public struct Condition {
    
    public enum Detail {
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
        
        
        public init(_ id: Int) {
            if id >= 200 && id < 300 {
                self = .Thunderstorm
            } else if id >= 300 && id < 400 {
                self = .ShowerRain
            } else if id >= 500 && id < 510 {
                self = .Rain
            } else if id >= 510 && id < 520 {
                self = .Snow
            } else if id > 520 && id < 600 {
                self = .ShowerRain
            } else if id >= 600 && id < 700 {
                self = .Snow
            } else if id >= 700 && id < 800 {
                self = .Mist
            } else if id == 800 {
                self = .ClearSky
            } else if id == 801 {
                self = .FewClouds
            } else if id == 802 {
                self = .ScatteredClouds
            } else if id >= 803 && id < 900 {
                self = .BrokenClouds
            } else {
                self = .Unknown
            }
        }
        
    }
    
    
    public enum Overview {
        case Unknow
        case Clear
        case Clowdy
        case Rainy
        case Snowy
        
        public init(_ detail: Detail) {
            switch detail {
            case .Unknown:
                self = .Unknow
            case .ClearSky, .FewClouds:
                self = .Clear
            case .ScatteredClouds, .BrokenClouds:
                self = .Clowdy
            case .ShowerRain, .Rain, .Thunderstorm, .Mist:
                self = .Rainy
            case .Snow:
                self = .Snowy
            }
        }
    }
    
    
    // MARK: - let
    
    public let id: Int
    public let overview: Overview
    public let detail: Detail
    public let description: String
    
    
    // MARK: - Initialize
    
    public init(id: Int, description: String) {
        self.id = id
        
        let detail = Detail(id)
        
        self.detail = detail
        self.overview = Overview(detail)
        self.description = description
    }
    
}
