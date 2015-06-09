//
//  APIClient.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/06/04.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import Result

public class APIClient {
    
    public typealias ParametersType = [String: AnyObject]
    
    // MARK: - let
    
    private let weatherAPI: WeatherAPI
    private let forecastAPI: ForecastAPI
    
    private let APPID: String
    
    
    // MARK: - Initialize
    
    init(APPID: String, weatherAPI: WeatherAPI, forecastAPI: ForecastAPI) {
        self.APPID = APPID
        self.weatherAPI = weatherAPI
        self.forecastAPI = forecastAPI
    }
    
    
    // MARK: - Public method
    
    /* Weather */
    
    public func getWetaher(#cityName: String, _ completion: WeatherAPIResult -> Void) {
        let parameters: ParametersType = [
            "APPID": APPID,
            "q": cityName
        ]
        
        weatherAPI.get(parameters: parameters, completion)
    }
    
    public func getWeather(#cityId: Int, _ completion: WeatherAPIResult -> Void) {
        let parameters: ParametersType = [
            "APPID": APPID,
            "id": cityId
        ]
        
        weatherAPI.get(parameters: parameters, completion)
    }
    
    public func getWeather(#coordinate: Coordinate, _ completion: WeatherAPIResult -> Void) {
        let parametres: ParametersType = [
            "APPID": APPID,
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        weatherAPI.get(parameters: parametres, completion)
    }
    
    public func getWeather(#zip: String, _ completion: WeatherAPIResult -> Void) {
        let parameters: ParametersType = [
            "APPID": APPID,
            "zip": zip
        ]
        
        weatherAPI.get(parameters: parameters, completion)
    }
    
    /* Forecast */

    public func getForecast(#cityName: String, _ completion: ForecastAPIResult -> Void) {
        let parameters: ParametersType = [
            "APPID": APPID,
            "q": cityName
        ]
        
        forecastAPI.get(parameters: parameters, completion)
    }
    
    public func getForecast(#cityId: Int, _ completion: ForecastAPIResult -> Void) {
        let parameters: ParametersType = [
            "APPID": APPID,
            "id": cityId
        ]
        
        forecastAPI.get(parameters: parameters, completion)
    }
    
    public func getForecast(#coordinate: Coordinate, _ completion: ForecastAPIResult -> Void) {
        let parameters: ParametersType = [
            "APPID": APPID,
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        forecastAPI.get(parameters: parameters, completion)
    }
    
    public func getForecast(#cityName: String, startDate: NSDate, _ completion: ForecastAPIResult -> Void) {
        let parameters: ParametersType = [
            "APPID": APPID,
            "q": cityName
        ]
        
        forecastAPI.get(parameters: parameters) { result in
            switch result {
            case .Success(let box):
                var filtered = box.value.filter {
                    return $0.date.timeIntervalSinceDate(startDate) > 0
                }
                
                completion(ForecastAPIResult(value: filtered))
            case .Failure(let box):
                completion(ForecastAPIResult(error: box.value))
            }
        }
    }
    
    public func getForecast(#cityId: Int, startDate: NSDate, _ completion: ForecastAPIResult -> Void) {
        let parameters: ParametersType = [
            "APPID": APPID,
            "id": cityId
        ]
        
        forecastAPI.get(parameters: parameters) { result in
            switch result {
            case .Success(let box):
                var filtered = box.value.filter {
                    return $0.date.timeIntervalSinceDate(startDate) > 0
                }
                
                completion(ForecastAPIResult(value: filtered))
            case .Failure(let box):
                completion(ForecastAPIResult(error: box.value))
            }
        }
    }
    
    public func getForecast(#coordinate: Coordinate, startDate: NSDate, _ completion: ForecastAPIResult -> Void) {
        let parameters: ParametersType = [
            "APPID": APPID,
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        forecastAPI.get(parameters: parameters) { result in
            switch result {
            case .Success(let box):
                var filtered = box.value.filter {
                    return $0.date.timeIntervalSinceDate(startDate) > 0
                }
                
                completion(ForecastAPIResult(value: filtered))
            case .Failure(let box):
                completion(ForecastAPIResult(error: box.value))
            }
        }
    }
    
}
