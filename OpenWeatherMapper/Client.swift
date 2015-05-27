//
//  Client.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import Result

public class Client {
    
    // MARK: - let
    
    private let weatherAPI: WeatherAPI
    private let forecastAPI: ForecastAPI
    
    
    // MARK: - Initialize
    
    init(weatherAPI: WeatherAPI, forecastAPI: ForecastAPI) {
        self.weatherAPI = weatherAPI
        self.forecastAPI = forecastAPI
    }
    
    
    // MARK: - Public method
    
    /* Weather */
    
    public func getWeather(#coordinte: Coordinate,
        _ completion: Result<Weather, NSError> -> Void) {
            weatherAPI.get(coordinate: coordinte, completion)
    }
    
    /* Forecast */
    
    public func getForecast(#coordinate: Coordinate,
        _ completion: Result<[Weather], NSError> -> Void) {
            forecastAPI.get(coordinate: coordinate, completion)
    }
    
    public func getForecast(#coordinate: Coordinate,
        startingDate: NSDate,
        _ completion: Result<[Weather], NSError> -> Void) {
            forecastAPI.get(coordinate: coordinate) { (result) -> Void in
                switch result {
                case .Success(let box):
                    var filtered = [Weather]()
                    
                    for weather in box.value {
                        if weather.date.timeIntervalSinceDate(startingDate) > 0 {
                            filtered.append(weather)
                        }
                    }
                    
                    completion(Result.success(filtered))
                case .Failure(let box):
                    completion(Result.failure(box.value))
                }
            }
    }
    
}
