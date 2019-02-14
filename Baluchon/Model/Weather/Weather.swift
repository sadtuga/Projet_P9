//
//  Weather.swift
//  Baluchon
//
//  Created by Marques Lucas on 22/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation


class WeatherService {
    
    private var weatherSession: URLSession // Stock a URLSessions
    private var task: URLSessionDataTask?  // Stock a URLSessionsDataTask
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    // Send a request to the OpenWeatherMap API and return this response
    func getWeather(city: String, callback: @escaping (Bool, WeatherInfo?) -> Void) {
        task?.cancel()
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&APPID=c36ebc3d6679d56f96c5f0ae011af988&units=metric")!
            task = weatherSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherInfo.self, from: data) else {
                        callback(false, nil)
                        return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}

