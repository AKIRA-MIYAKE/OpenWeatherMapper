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
    
    typealias ResultType
    
    func get(#parameters: [String: AnyObject], _ completion: ResultType -> Void)
    
}