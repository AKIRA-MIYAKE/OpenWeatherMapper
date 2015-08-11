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


public typealias GetWeatherResult = Result<Weather, NSError>
public typealias GetForecastResult = Result<[Weather], NSError>
public typealias GetDailyForecastResult = Result<[Weather], NSError>


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
    
    public func getWeather(#cityName: String, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["q": cityName]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(#cityName: String, countryCode: String, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["q": "\(cityName),\(countryCode)"]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(#cityId: Int, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["id": cityId]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(#coordinate: Coordinate, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(#zipCode: String, countryCode: String, _ completion: GetWeatherResult -> Void) {
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
            .responseJSON { (request, response, data, error) -> Void in
                if let error = error {
                    let result = GetWeatherResult.failure(error)
                    completion(result)
                } else {
                    if let data: AnyObject = data {
                        let result = self.weatherResponseParser.parse(data)
                        completion(result)
                    } else {
                        let error = NSError(
                            domain: ErrorDomain,
                            code: ErrorCode.Unknown.rawValue,
                            userInfo: nil)
                        
                        let result = GetWeatherResult.failure(error)
                        completion(result)
                    }
                }
            }
    }
    
    
    // MARK: - 5 day / 3 hour forecast
    
    public func getForecast(#cityName: String, _ completion: GetForecastResult -> Void) {
        let parameters: [String: AnyObject] = ["q": cityName]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(#cityName: String, countryCode: String, _ completion: GetForecastResult -> Void) {
        let parameters: [String: AnyObject] = ["q": "\(cityName),\(countryCode)"]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(#cityId: Int, _ completion: GetForecastResult -> Void) {
        let parameters: [String: AnyObject] = ["id": cityId]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(#coordinate: Coordinate, _ completion: GetForecastResult -> Void) {
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
            .responseJSON { (request, response, data, error) -> Void in
                if let error = error {
                    let result = GetForecastResult.failure(error)
                    completion(result)
                } else {
                    if let data: AnyObject = data {
                        let result = self.forecastResponseParser.parse(data)
                        completion(result)
                    } else {
                        let error = NSError(
                            domain: ErrorDomain,
                            code: ErrorCode.Unknown.rawValue,
                            userInfo: nil)
                        
                        let result = GetForecastResult.failure(error)
                        completion(result)
                    }
                }
            }
    }
    
    
    // MARK: - 16 day / daily forecast
    
    public func getDailyForecast(#cityName: String, count: Int, _ completion: GetDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "q": cityName,
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(#cityName: String, coutnryCode: String, count: Int, _ completion: GetDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "q": "\(cityName),\(coutnryCode)",
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(#cityId: Int, count: Int, _ completion: GetDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "id": cityId,
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(#coordinate: Coordinate, count: Int, _ completion: GetDailyForecastResult -> Void) {
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
            .responseJSON { (request, response, data, error) -> Void in
                if let error = error {
                    let result = GetDailyForecastResult.failure(error)
                    completion(result)
                } else {
                    if let data: AnyObject = data {
                        let result = self.dailyForecastResponseParser.parse(data)
                        completion(result)
                    } else {
                        let error = NSError(
                            domain: ErrorDomain,
                            code: ErrorCode.Unknown.rawValue,
                            userInfo: nil)
                        
                        let result = GetDailyForecastResult.failure(error)
                        completion(result)
                    }
                }
            }
    }
    
}
