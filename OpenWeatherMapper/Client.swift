//
//  Client.swift
//  OpenWeatherMapper
//
//  Created by MiyakeAkira on 2015/10/26.
//  Copyright © 2015年 Miyake Akira. All rights reserved.
//

import Alamofire


public class Client {
    
    // MARK: - API Settings
    
    public let scheme = "http"
    public let baseURLString = "api.openweathermap.org"
    
    
    // MARK: - let
    
    public let APPID: String
    
    
    // MARK: - Initialize
    
    public init(APPID: String) {
        self.APPID = APPID
    }
    
    
    // MARK: - Method
    
    public func call<T: Request>(request: T, _ completion: ResultResult<T.Entity, Error>.r -> Void) {
        let URLString = "\(scheme)://\(baseURLString)\(request.path)"
        let method = Alamofire.Method(rawValue: request.method)!
        
        var parameters: [String: AnyObject] = ["APPID": APPID]
        for (key, value) in request.parameters {
            parameters[key] = value
        }
        
        Alamofire.request(method, URLString, parameters: parameters)
            .responseJSON { (response) -> Void in
                switch response.result {
                case .Success(let data):
                    if let entity = request.parse(data) {
                        let result = ResultResult<T.Entity, Error>.r.Success(entity)
                        completion(result)
                    } else {
                        let error = Error.ServiceError
                        let result = ResultResult<T.Entity, Error>.r.Failure(error)
                        completion(result)
                    }
                case .Failure(_):
                    let error = Error.UnreachableServerError
                    let result = ResultResult<T.Entity, Error>.r.Failure(error)
                    completion(result)
                }
            }
    }
    
}
