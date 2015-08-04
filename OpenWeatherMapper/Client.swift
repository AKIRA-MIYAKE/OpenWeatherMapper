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
    
    
    // MARK: - Initialize
    
    public init(APPID: String) {
        self.APPID = APPID
    }
    
    
    // MARK: - Current weather data
    
    public func getWeather(#cityName: String, _ completion: GetWeatherResult -> Void) {
        let parameters: [String: AnyObject] = ["q": cityName]
        
        getWeather(parameters, completion)
    }
    
    public func getWeather(parameters: [String: AnyObject], _ completion: GetWeatherResult -> Void) {
        let urlString = "\(BaseURL)\(API.Weather.rawValue)"
        
        Alamofire.request(.GET, urlString, parameters: parameters)
            .responseJSON { (request, response, data, error) -> Void in
                let result = GetWeatherResult.failure(NSError(domain: "", code: 0, userInfo: nil))
                completion(result)
            }
    }
    
    
    // MARK: - 5 day / 3 hour forecast
    
    public func getForecast(parameters: [String: AnyObject], _ completion: GetForecastResult -> Void) {
        let urlString = "\(BaseURL)\(API.Forecast.rawValue)"
        
        Alamofire.request(.GET, urlString, parameters: parameters)
            .responseJSON { (request, response, data, error) -> Void in
                let result = GetForecastResult.failure(NSError(domain: "", code: 0, userInfo: nil))
                completion(result)
            }
    }
    
}
