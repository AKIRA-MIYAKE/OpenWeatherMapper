//
//  Place.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public struct Place {
    
    public let id: Int
    public let city: String
    public let country: String
    
    public init(id: Int, city: String, country: String) {
        self.id = id
        self.city = city
        self.country = country
    }
    
}
