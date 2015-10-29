//
//  City.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/10/27.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

public struct City {
    
    public let id: Int
    public let name: String
    public let country: String
    
    public init(id: Int, name: String, country: String) {
        self.id = id
        self.name = name
        self.country = country
    }
    
}
