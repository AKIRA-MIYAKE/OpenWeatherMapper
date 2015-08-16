//
//  Client.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/04.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import Alamofire
import Result


public let ErrorDomain = "con.dream-of-electric-cat.OpenWeatherMapper"

public enum ErrorCode: Int {
    case Unknown
    case ParseError
}


public let BaseURL = "http://api.openweathermap.org/data/2.5/"

public enum API: String {
    case Weather = "weather"
    case Forecast = "forecast"
    case DailyForecast = "forecast/daily"
}


public class Client {
    
    // MARK: - let
    
    public let APPID: String
    
    private let weatherResponseParser: WeatherResponseParser
    private let forecastResponseParser: ForecastResponseParser
    private let dailyForecastResponseParser: DailyForecastResponseParser
    
    
    // MARK: - Initialize
    
    convenience public init(APPID: String) {
        self.init(
            APPID: APPID,
            weatherResponseParser: WeatherResponseParser(),
            forecastResponseParser: ForecastResponseParser(),
            dailyForecastResponseParser: DailyForecastResponseParser())
    }
    
    public init(
        APPID: String,
        weatherResponseParser: WeatherResponseParser,
        forecastResponseParser: ForecastResponseParser,
        dailyForecastResponseParser: DailyForecastResponseParser)
    {
        self.APPID = APPID
        self.weatherResponseParser = weatherResponseParser
        self.forecastResponseParser = forecastResponseParser
        self.dailyForecastResponseParser = dailyForecastResponseParser
    }
    
    
    // MARK: - Current weather data
    
    public func getWeather(cityName cityName: String, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["q": cityName]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(cityName cityName: String, countryCode: String, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["q": "\(cityName),\(countryCode)"]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(cityId cityId: Int, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["id": cityId]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(coordinate coordinate: Coordinate, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(zipCode zipCode: String, countryCode: String, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["zip": "\(zipCode),\(countryCode)"]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(parameters: [String: AnyObject], _ completion: GetWeatherResult -> Void) {
        let urlString = "\(BaseURL)\(API.Weather.rawValue)"
        
        var _parameters: [String: AnyObject] = ["APPID": APPID]
        for (key, value) in parameters {
            _parameters[key] = value
        }
        
        Alamofire.request(.GET, urlString, parameters: _parameters)
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let result = self.weatherResponseParser.parse(value)
                    completion(result)
                case .Failure(_, let error):
                    let result = GetWeatherResult.Failure(error)
                    completion(result)
                }
            }
    }
    
    
    // MARK: - 5 day / 3 hour forecast
    
    public func getForecast(cityName cityName: String, _ completion: GetForecastResult -> Void) {
        let parameters: [String: AnyObject] = ["q": cityName]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(cityName cityName: String, countryCode: String, _ completion: GetForecastResult -> Void) {
        let parameters: [String: AnyObject] = ["q": "\(cityName),\(countryCode)"]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(cityId cityId: Int, _ completion: GetForecastResult -> Void) {
        let parameters: [String: AnyObject] = ["id": cityId]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(coordinate coordinate: Coordinate, _ completion: GetForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(parameters: [String: AnyObject], _ completion: GetForecastResult -> Void) {
        let urlString = "\(BaseURL)\(API.Forecast.rawValue)"
        
        var _parameters: [String: AnyObject] = ["APPID": APPID]
        for (key, value) in parameters {
            _parameters[key] = value
        }
        
        Alamofire.request(.GET, urlString, parameters: _parameters)
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let result = self.forecastResponseParser.parse(value)
                    completion(result)
                case .Failure(_, let error):
                    let result = GetForecastResult.Failure(error)
                    completion(result)
                }
        }
    }
    
    
    // MARK: - 16 day / daily forecast
    
    public func getDailyForecast(cityName cityName: String, count: Int, _ completion: GetDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "q": cityName,
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(cityName cityName: String, coutnryCode: String, count: Int, _ completion: GetDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "q": "\(cityName),\(coutnryCode)",
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(cityId cityId: Int, count: Int, _ completion: GetDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "id": cityId,
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(coordinate coordinate: Coordinate, count: Int, _ completion: GetDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude,
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(parameters: [String: AnyObject], _ completion: GetDailyForecastResult -> Void) {
        let urlString = "\(BaseURL)\(API.DailyForecast.rawValue)"
        
        var _parameters: [String: AnyObject] = ["APPID": APPID]
        for (key, value) in parameters {
            _parameters[key] = value
        }
        
        Alamofire.request(.GET, urlString, parameters: parameters)
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let result = self.dailyForecastResponseParser.parse(value)
                    completion(result)
                case .Failure(_, let error):
                    let result = GetDailyForecastResult.Failure(error)
                    completion(result)
                }
        }
    }
    
}
