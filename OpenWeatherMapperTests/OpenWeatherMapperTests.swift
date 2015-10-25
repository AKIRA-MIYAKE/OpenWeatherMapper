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
    
    var client: Client?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = Client(APPID: "bd82977b86bf27fb59a04b61b657fb6f")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetWeather() {
        let expectation = expectationWithDescription("Get current weather")
        
        let coordinate = Coordinate(latitude: 35, longitude: 139)
        let request = GetWeatherRequest(coordinate)
        
        client!.call(request) { (result) -> Void in
            switch result {
            case .Success(let value):
                print(value)
                expectation.fulfill()
            case .Failure(let error):
                print(error)
                XCTAssert(false)
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testGetForecast() {
        let expectation = expectationWithDescription("Get forecast")
        
        let coordinate = Coordinate(latitude: 35, longitude: 139)
        let request = GetForecastRequest(coordinate)
        
        client!.call(request) { (result) -> Void in
            switch result {
            case .Success(let value):
                print(value.first)
                expectation.fulfill()
            case .Failure(let error):
                print(error)
                XCTAssert(false)
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testGetDailyForecast() {
        let expectation = expectationWithDescription("Get daily forecast")
        
        let coordinate = Coordinate(latitude: 35, longitude: 139)
        let request = GetDailyForecastRequest(coordinate, count: 7)
        
        client!.call(request) { (result) -> Void in
            switch result {
            case .Success(let value):
                XCTAssertEqual(value.count, 7)
                expectation.fulfill()
            case .Failure(let error):
                print(error)
                XCTAssert(false)
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
}