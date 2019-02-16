//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Marques Lucas on 16/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet var destination: [UITextField]!
    @IBOutlet var iconWeather: [UIImageView]!
    @IBOutlet var descriptionWeather: [UILabel]!
    @IBOutlet var info: [UIStackView]!
    @IBOutlet var forecastButton: UIButton!
    @IBOutlet var weatherActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var temp: [UILabel]!
    @IBOutlet var wind: [UILabel]!
    
    var weather = WeatherService() // Stock the instance of the WeatherService class
    
    // Removes the keyboard and stores the text entered in the destination variable
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        destination[0].resignFirstResponder()
        destination[1].resignFirstResponder()
    }
    
    // Manages the data received by the API
    @IBAction func didTapeWeatherForecastButton(_ sender: Any) {
        
        guard destination[0].text != "", destination[1].text != "" else {
            alert(title: "Erreur", message: "Aucune destination saisis")
            return
        }
        
        hideButton(button: forecastButton, activityIndicator: weatherActivityIndicator)

        for i in 0...1 {
            weather.getWeather(city: destination[i].text!) { (success, weather) in
                if success == true {
                    self.refreshScreen(weather: weather!, index: i)
                } else if success == false {
                    self.alert(title: "Erreur", message: "Une erreur est survenue vérifier la Ville saisie et la connexion internet")
                }
            }
        }
        
        displayButton(button: forecastButton, activityIndicator: weatherActivityIndicator)
    }
    
    // Shows weather information
    private func refreshScreen(weather: WeatherInfo, index: Int) {
            info[index].isHidden = false
            temp[index].text = convertToString(value: weather.main.temp) + "°C"
            wind[index].text = convertToString(value: weather.wind.speed) + "km/h"
            descriptionWeather[index].text = weather.weather[0].main
            descriptionWeather[index].isHidden = false
            iconWeather[index].isHidden = false
            iconWeather[index].image = WeatherView.icon[weather.weather[0].main]
    }

}

