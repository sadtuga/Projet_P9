//
//  ExchangeRateModelTestCase.swift
//  BaluchonTests
//
//  Created by Marques Lucas on 28/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import XCTest
@testable import Baluchon

class ExchangeRateModelTestCase: XCTestCase {
    
    let exchangeRate = ExchangeRate()
    var sum: String = ""
    var rate: Double = 0

    func testGivenAnAmountHasBeenSeized_WhenCalculateTheResult_ThenTheResultIsCalculated() {
        let sum = "12.54"
        let result = exchangeRate.convert(sum: sum)
        XCTAssertEqual(12.54, result)
    }
    
    func testGivenTheAmountCannotBeConverted_WhenWeModifyIt_ThenWeGetTheRightResult() {
        let sum = "12,54"
        let result = exchangeRate.convert(sum: sum)
        XCTAssertEqual(12.54, result)
    }
    
    func testGetRateShouldPostFailedCallbackIfError() {
        let exchangeRate = ExchangeRate(rateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeRate.getRate { (success, rate) in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfNoData() {
        let exchangeRate = ExchangeRate(rateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeRate.getRate { (success, rate) in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIncorrectResponse() {
        let exchangeRate = ExchangeRate(rateSession: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeRate.getRate { (success, rate) in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIncorrectData() {
        let exchangeRate = ExchangeRate(rateSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeRate.getRate { (success, rate) in
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let exchangeRate = ExchangeRate(rateSession: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       
        exchangeRate.getRate { (success, rate) in
            XCTAssertTrue(success)
            XCTAssertNotNil(rate)
            
            let fakeRate: Float = 1.14323
            
            XCTAssertEqual(fakeRate, rate!)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

}
