//
//  OpenWeatherMapper.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation

public class OpenWeatherMapper {
    
    public static var baseURL = "http://api.openweathermap.org/data/2.5/"
    public static var weatherAPIPath = "weather"
    public static var forecastAPIPath = "forecast"
    
    public static func defaultClient(#APPID: String) -> Client {
        let weatherAPI = WeatherAPI(
            parser: WeatherAPIParser(),
            baseURL: baseURL,
            apiPath: weatherAPIPath,
            APPID: APPID)
        
        let forecastAPI = ForecastAPI(
            parser: ForecastAPIParser(),
            baseURL: baseURL,
            apiPath: forecastAPIPath,
            APPID: APPID)
        
        return Client(weatherAPI: weatherAPI, forecastAPI: forecastAPI)
    }
    
}
