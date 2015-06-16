//
//  DailyForecastAPIResult.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/06/16.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import Result

public typealias DailyForecastAPIResult = Result<[DailyWeather], NSError>