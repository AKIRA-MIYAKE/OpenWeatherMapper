//
//  OpenWeatherMapperTests.swift
//  OpenWeatherMapperTests
//
//  Created by MiyakeAkira on 2015/05/27.
//  Copyright (c) 2015年 Miyake Akira. All rights reserved.
//

import XCTest
import OpenWeatherMapper

class OpenWeatherMapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetWeather() {
        let expectation = expectationWithDescription("Get weather")
        
        let client = Client(APPID: "")
        client.getWeather(["q": "Tokyo"]) { result in
            switch result {
            case .Success(let value):
                print(value.condition.main.toString())
                expectation.fulfill()
            case .Failure(let error):
                print(error)
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testGetWeatherWithCoordinate() {
        let expectation = expectationWithDescription("Get weather")
        
        let client = Client(APPID: "")
        let coord = Coordinate(latitude: 35, longitude: 139)
        client.getWeather(coordinate: coord) { result in
            switch result {
            case .Success(let value):
                print(value.condition.main.toString())
                expectation.fulfill()
            case .Failure(let error):
                print(error)
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testGetForecast() {
        let expectation = expectationWithDescription("Get forecast")
        
        let client = Client(APPID: "")
        client.getForecast(["q": "Tokyo"]) { result in
            switch result {
            case .Success(let value):
                if value.count > 0 {
                    print(value[0].condition.main.toString())
                    expectation.fulfill()
                }
            case .Failure(let error):
                print(error)
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testGetForecastWithCoordinate() {
        let expectation = expectationWithDescription("Get forecast")
        
        let client = Client(APPID: "")
        let coord = Coordinate(latitude: 35, longitude: 139)
        client.getForecast(coordinate: coord) { result in
            switch result {
            case .Success(let value):
                if value.count > 0 {
                    print(value[0].condition.main.toString())
                    expectation.fulfill()
                }
            case .Failure(let error):
                print(error)
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testGetDailyForecast() {
        let expectation = expectationWithDescription("Get daily forecast")
        
        let client = Client(APPID: "")
        client.getDailyForecast(["q": "Tokyo", "cnt": 16]) { result in
            switch result {
            case .Success(let value):
                if value.count > 0 {
                    print(value[0].condition.main.toString())
                    expectation.fulfill()
                }
            case .Failure(let error):
                print(error)
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testGetDailyForecastWithCoordinate() {
        let expectation = expectationWithDescription("Get daily forecast")
        
        let client = Client(APPID: "")
        let coord = Coordinate(latitude: 35, longitude: 139)
        client.getDailyForecast(coordinate: coord, count: 16) { result in
            switch result {
            case .Success(let value):
                if value.count > 0 {
                    print(value[0].condition.main.toString())
                    expectation.fulfill()
                }
            case .Failure(let error):
                print(error)
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
}
