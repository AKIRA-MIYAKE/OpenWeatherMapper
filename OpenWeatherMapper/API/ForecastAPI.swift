//
//  ForecastAPI.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import Alamofire
import Result

class ForecastAPI: APIProtocol {
    
    typealias Value = [Weather]
    
    // MARK: - let
    
    private let parser: ForecastAPIParser
    private let baseURL: String
    private let apiPath: String
    private let APPID: String
    
    
    // MARK: - Initialize
    
    init(parser: ForecastAPIParser, baseURL: String, apiPath: String, APPID: String) {
        self.parser = parser
        
        self.baseURL = baseURL
        self.apiPath = apiPath
        self.APPID = APPID
    }
    
    
    // MARK: - Method
    
    func get(#coordinate: Coordinate, _ completion: Result<Value, NSError> -> Void) {
        let URL = baseURL + apiPath
        let parameters: [String: AnyObject] = [
            "APPID": APPID,
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        Alamofire.request(.GET, URL, parameters: parameters)
            .responseJSON { (request, response, data, error) -> Void in
                let result: Result<[Weather], NSError>
                
                if let error = error {
                    result = Result.failure(error)
                } else {
                    if let data: AnyObject = data {
                        result = self.parser.parse(data)
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        result = Result.failure(error)
                    }
                }
                
                completion(result)
        }
    }
    
}