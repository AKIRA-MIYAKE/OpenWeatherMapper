//
//  Request.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/10/26.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

public protocol Request {
    
    typealias Entity: Any
    
    var path: String { get }
    var method: String { get }
    var parameters: [String: AnyObject] { get }
    
    func parse(data: AnyObject) -> Entity?
    
}
