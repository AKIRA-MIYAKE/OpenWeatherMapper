//
//  Results.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/16.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

import Result


public typealias GettingWeatherResult = Result<Weather, OpenWeatherMapperError>
public typealias GettingForecastResult = Result<[Weather], OpenWeatherMapperError>
public typealias GettingDailyForecastResult = Result<[Weather], OpenWeatherMapperError>