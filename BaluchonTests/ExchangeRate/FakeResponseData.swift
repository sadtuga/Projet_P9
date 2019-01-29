//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Marques Lucas on 29/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var rateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Rate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let rateIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    class rateError: Error {}
    static let error = rateError()
}
