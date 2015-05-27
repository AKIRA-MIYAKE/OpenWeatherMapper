//
//  APIProtocol.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import Result

protocol APIProtocol {
    
    typealias Value
    
    func get(#coordinate: Coordinate, _ completion: Result<Value, NSError> -> Void)
    
}