//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Marques Lucas on 16/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var iconWeather: UIImageView!
    @IBOutlet weak var descriptionWeather: UILabel!
    @IBOutlet weak var info: UIStackView!
    @IBOutlet weak var forecastButton: UIButton!
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var wind: UILabel!
    
    var weather = WeatherService() // Stock the instance of the WeatherService class
    
    // Removes the keyboard and stores the text entered in the destination variable
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        destination.resignFirstResponder()
    }
    
    // Manages the data received by the API
    @IBAction func didTapeWeatherForecastButton(_ sender: Any) {
        guard let city = destination.text, city != "" else {
            alert(title: "Erreur", message: "Aucune destination saisis")
            return
        }
        
        hideButton(button: forecastButton, activityIndicator: weatherActivityIndicator)
        
        weather.getWeather(city: destination.text!) { (success, weather) in
            if success == true {
                self.refreshScreen(weather: weather!)
            } else if success == false {
                self.alert(title: "Erreur", message: "Une erreur est survenue vérifier la Ville saisie et la connexion internet")
            }
        }
        
        displayButton(button: forecastButton, activityIndicator: weatherActivityIndicator)
        
    }
    
    // Shows weather information
    private func refreshScreen(weather: WeatherInfo) {
        info.isHidden = false
        temp.text = convertToString(value: weather.main.temp) + "°C"
        wind.text = convertToString(value: weather.wind.speed) + "km/h"
        descriptionWeather.text = weather.weather[0].main
        descriptionWeather.isHidden = false
        iconWeather.isHidden = false
        iconWeather.image = WeatherView.icon[weather.weather[0].main]
    }

}

