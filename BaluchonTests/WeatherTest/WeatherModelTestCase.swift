//
//  WeatherModelTestCase.swift
//  BaluchonTests
//
//  Created by Marques Lucas on 06/02/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherModelTestCase: XCTestCase {

    func testTranslateShouldPostFailedCallbackIfError() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "London") { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIfNoData() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "London") { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIncorrectResponse() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "London") { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIncorrectData() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "London") { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "London") { (success, weather) in
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            
            let fakeWeatherWind: Float = 3.6
            let fakeWeatherTemp: Float = 10.18
            let fakeWeather: String = "Clouds"
            
            XCTAssertEqual(fakeWeatherWind, weather?.wind.speed)
            XCTAssertEqual(fakeWeatherTemp, weather?.main.temp)
            XCTAssertEqual(fakeWeather, weather?.weather[0].main)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

}
