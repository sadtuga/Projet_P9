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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var wind: UILabel!
    
    var weather = WeatherService()
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        destination.resignFirstResponder()
    }
    
    @IBAction func didTapeWeatherForecastButton(_ sender: Any) {
        guard let city = destination.text, city != "" else {
            alert(title: "Erreur", message: "Aucune destination saisis")
            return
        }
        
        displayButton(button: true, activityIndicator: false)
        
        weather.getWeather(city: destination.text!) { (success, weather) in
            if success == true {
                self.refreshScreen(weather: weather!)
            } else if success == false {
                self.alert(title: "Erreur", message: "Une erreur est survenue vérifier la Ville saisie et la connexion internet")
            }
        }
        
        displayButton(button: false, activityIndicator: true)
        
    }
    
    private func refreshScreen(weather: WeatherInfo) {
        info.isHidden = false
        temp.text = convertToString(value: weather.main.temp) + "°C"
        wind.text = convertToString(value: weather.wind.speed) + "km/h"
        descriptionWeather.text = weather.weather[0].main
        descriptionWeather.isHidden = false
        iconWeather.isHidden = false
        iconWeather.image = WeatherView.icon[weather.weather[0].main]
    }
    
    private func displayButton(button: Bool, activityIndicator: Bool) {
        forecastButton.isHidden = button
        self.activityIndicator.isHidden = activityIndicator
    }
    
}

