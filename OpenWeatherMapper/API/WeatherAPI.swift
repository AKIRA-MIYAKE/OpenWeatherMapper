//
//  WeatherAPI.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import Foundation
import Alamofire
import Result

class WeatherAPI: APIProtocol {
    
    typealias ResultType = WeatherAPIResult
    
    // MARK: - let
    
    private let parser: WeatherAPIParser
    private let baseURL: String
    private let apiPath: String
    
    
    // MARK: - Initialize
    
    init(parser: WeatherAPIParser, baseURL: String, apiPath: String) {
        self.parser = parser
        
        self.baseURL = baseURL
        self.apiPath = apiPath
    }
    
    
    // MARK: - API protocol
    
    func get(#parameters: [String : AnyObject], _ completion: ResultType -> Void) {
        let URL = baseURL + apiPath
        
        Alamofire.request(.GET, URL, parameters: parameters)
            .responseJSON { (request, response, data, error) -> Void in
                let result: ResultType
                
                if let error = error {
                    result = ResultType(error: error)
                } else {
                    if let data: AnyObject = data {
                        result = self.parser.parse(data)
                    } else {
                        let error = NSError(
                            domain: Const.errorDomain,
                            code: Const.ErrorCode.Unknown.rawValue,
                            userInfo: nil)
                        result = ResultType(error: error)
                    }
                }
                
                completion(result)
            }
    }
    
}