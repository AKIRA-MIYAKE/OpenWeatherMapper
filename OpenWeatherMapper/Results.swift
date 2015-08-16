//
//  Results.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/16.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

import Result


public typealias GetWeatherResult = Result<Weather, NSError>
public typealias GetForecastResult = Result<[Weather], NSError>
public typealias GetDailyForecastResult = Result<[Weather], NSError>