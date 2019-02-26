//
//  currency.swift
//  Baluchon
//
//  Created by Marques Lucas on 22/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//



import Foundation

class ExchangeRate {
    
    private let url = URL(string: "http://data.fixer.io/api/latest?access_key=267465fe1f169299d11355d4acffc4e5&base=EUR&symbols=USD")! // Stock the URL of the API
    private var rateSession: URLSession   // Stock a URLSessions
    private var task: URLSessionDataTask? // Stock a URLSessionsDataTask
    
    init(rateSession: URLSession = URLSession(configuration: .default)) {
        self.rateSession = rateSession
    }
    
    // Send a request to the Fixer.io API and return this response
    func getRate(callback: @escaping (Bool, Float?) -> Void) {
        task?.cancel()
        task = rateSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data),
                    let rate = responseJSON.rates["USD"] else {
                        callback(false, nil)
                        return
                }
                callback(true, rate)
            }
        }
        task?.resume()
    }
    
    // Convert the received parameter to a float
    func convert(sum: String) -> Float {
        var convertibleSum: String = sum
        if convertibleSum.contains(",") == true {
            convertibleSum = convertPunctuation(sum: sum)
        }
        if let convertSum = Float(convertibleSum) {
            return convertSum
        } else {
            return 0
        }
    }
    
    // Convert a comma to a point
    private func convertPunctuation(sum: String) -> String {
        var buffer = sum
        let index = sum.firstIndex(of: ",")
        buffer.insert(".", at: index!)
        let indexToDelete = buffer.index(after: index!)
        buffer.remove(at: indexToDelete)
        buffer = buffer.replacingOccurrences(of: ",", with: "")
        return buffer
    }
    
}
