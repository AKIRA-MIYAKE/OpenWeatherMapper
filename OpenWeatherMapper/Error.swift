//
//  Error.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/30.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

public enum OpenWeatherMapperError: ErrorType {
    case UnknownError
    case NetworkError
    case ParseError(AnyObject)
}
