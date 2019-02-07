//
//  currency.swift
//  Baluchon
//
//  Created by Marques Lucas on 22/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//



import Foundation

class ExchangeRate {
    
    private var url = URL(string: "http://data.fixer.io/api/latest?access_key=267465fe1f169299d11355d4acffc4e5&base=EUR&symbols=USD")!
    private var rateSession: URLSession
    private var task: URLSessionDataTask?
    
    init(rateSession: URLSession = URLSession(configuration: .default)) {
        self.rateSession = rateSession
    }
    
    
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
    
    private func convertPunctuation(sum: String) -> String {
        var buffer = sum
        let index = sum.firstIndex(of: ",")
        buffer.insert(".", at: index!)
        let indexToDelete = buffer.index(after: index!)
        buffer.remove(at: indexToDelete)
        return buffer
    }
    
}
