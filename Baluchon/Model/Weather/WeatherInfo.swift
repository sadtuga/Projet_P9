//
//  WeatherInfo.swift
//  Baluchon
//
//  Created by Marques Lucas on 04/02/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation


// The structure of this file makes it possible to store the OpenWeatherMap API data
struct WeatherInfo: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Weather: Decodable {
    let main: String
}

struct Main: Decodable {
    let temp: Float
}

struct Wind: Decodable {
    let speed: Float
}
