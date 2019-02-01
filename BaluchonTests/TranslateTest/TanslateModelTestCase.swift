//
//  TanslateModelTestCase.swift
//  BaluchonTests
//
//  Created by Marques Lucas on 01/02/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import XCTest
@testable import Baluchon

class TanslateModelTestCase: XCTestCase {

    func testTranslateShouldPostFailedCallbackIfError() {
        let translate = Translate(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(Index: 0, text: "Bonjour") { (success, translatedText) in
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIfNoData() {
        let translate = Translate(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(Index: 0, text: "Bonjour") { (success, translatedText) in
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIncorrectResponse() {
        let translate = Translate(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(Index: 0, text: "Bonjour") { (success, translatedText) in
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIncorrectData() {
        let translate = Translate(translateSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(Index: 0, text: "Bonjour") { (success, translatedText) in
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translate = Translate(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(Index: 0, text: "Bonjour") { (success, translatedText) in
            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText)
            
            let fakeTranslation: String = "Hello"
            
            XCTAssertEqual(fakeTranslation, translatedText!)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
