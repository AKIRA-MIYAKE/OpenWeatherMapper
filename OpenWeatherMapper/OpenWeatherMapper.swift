//
//  OpenWeatherMapper.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public class OpenWeatherMapper {
    
    public static var baseURL = Const.baseURLString
    public static var weatherAPIPath = Const.weatherAPIPath
    public static var forecastAPIPath = Const.forecastAPIPath
    public static var dailyForecastAPIPath = Const.dailyForecastAPIPath
    
    public static func defaultClient(#APPID: String) -> APIClient {
        let weatherAPI = WeatherAPI(
            parser: WeatherAPIParser(),
            baseURL: baseURL,
            apiPath: weatherAPIPath)
        
        let forecastAPI = ForecastAPI(
            parser: ForecastAPIParser(),
            baseURL: baseURL,
            apiPath: forecastAPIPath)
        
        let dailyForecastAPI = DailyForecastAPI(
            parser: DailyForecastAPIParser(),
            baseURL: baseURL,
            apiPath: dailyForecastAPIPath)
        
        return APIClient(
            APPID: APPID,
            weatherAPI: weatherAPI,
            forecastAPI: forecastAPI,
            dailyForecastAPI: dailyForecastAPI)
    }
    
}
