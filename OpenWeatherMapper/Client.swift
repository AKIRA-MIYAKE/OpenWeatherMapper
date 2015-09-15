//
//  Client.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/08/04.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Alamofire
import Result


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
    
    public func getWeather(cityName cityName: String, _ completion: GettingWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["q": cityName]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(cityName cityName: String, countryCode: String, _ completion: GettingWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["q": "\(cityName),\(countryCode)"]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(cityId cityId: Int, _ completion: GettingWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["id": cityId]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(coordinate coordinate: Coordinate, _ completion: GettingWeatherResult -> Void) {
        let parameters: [String: AnyObject] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(zipCode zipCode: String, countryCode: String, _ completion: GettingWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["zip": "\(zipCode),\(countryCode)"]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(parameters: [String: AnyObject], _ completion: GettingWeatherResult -> Void) {
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
                case .Failure(_, _):
                    let error = OpenWeatherMapperError.NetworkError
                    let result = GettingWeatherResult.Failure(error)
                    completion(result)
                }
            }
    }
    
    
    // MARK: - 5 day / 3 hour forecast
    
    public func getForecast(cityName cityName: String, _ completion: GettingForecastResult -> Void) {
        let parameters: [String: AnyObject] = ["q": cityName]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(cityName cityName: String, countryCode: String, _ completion: GettingForecastResult -> Void) {
        let parameters: [String: AnyObject] = ["q": "\(cityName),\(countryCode)"]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(cityId cityId: Int, _ completion: GettingForecastResult -> Void) {
        let parameters: [String: AnyObject] = ["id": cityId]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(coordinate coordinate: Coordinate, _ completion: GettingForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        getForecast(parameters, completion)
    }
    
    public func getForecast(parameters: [String: AnyObject], _ completion: GettingForecastResult -> Void) {
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
                case .Failure(_, _):
                    let error = OpenWeatherMapperError.NetworkError
                    let result = GettingForecastResult.Failure(error)
                    completion(result)
                }
        }
    }
    
    
    // MARK: - 16 day / daily forecast
    
    public func getDailyForecast(cityName cityName: String, count: Int, _ completion: GettingDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "q": cityName,
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(cityName cityName: String, coutnryCode: String, count: Int, _ completion: GettingDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "q": "\(cityName),\(coutnryCode)",
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(cityId cityId: Int, count: Int, _ completion: GettingDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "id": cityId,
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(coordinate coordinate: Coordinate, count: Int, _ completion: GettingDailyForecastResult -> Void) {
        let parameters: [String: AnyObject] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude,
            "cnt": count
        ]
        
        getDailyForecast(parameters, completion)
    }
    
    public func getDailyForecast(parameters: [String: AnyObject], _ completion: GettingDailyForecastResult -> Void) {
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
                case .Failure(_, _):
                    let error = OpenWeatherMapperError.NetworkError
                    let result = GettingDailyForecastResult.Failure(error)
                    completion(result)
                }
        }
    }
    
}
