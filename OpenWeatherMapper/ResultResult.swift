//
//  ResultResult.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/10/26.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

import Result

public struct ResultResult<T, Error: ErrorType> {
    public typealias r = Result<T, Error>
}
