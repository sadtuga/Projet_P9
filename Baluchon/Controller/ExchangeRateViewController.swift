//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by Marques Lucas on 16/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var sum: UITextField!
    @IBOutlet weak var rateActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var result: UITextView!
    @IBOutlet weak var rate: UITextView!
    
    private var currency = ExchangeRate() // Stock the instance of the ExchangeRate class
    
    override func viewDidLoad() {
        let firstNotif = Notification.Name(rawValue: "Erreur réseau!")
        NotificationCenter.default.addObserver(self, selector: #selector(networkError), name: firstNotif, object: nil)
        
        let secondNotif = Notification.Name(rawValue: "Réponse serveur incorrect!")
        NotificationCenter.default.addObserver(self, selector: #selector(incorrectServerResponse), name: secondNotif, object: nil)
        
        let thirdNotif = Notification.Name(rawValue: "Data illisible!")
        NotificationCenter.default.addObserver(self, selector: #selector(dataUnreadable), name: thirdNotif, object: nil)
    }
    
    // Removes the keyboard and stores the text entered in the sum variable
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sum.resignFirstResponder()
    }
    
    // Manages the data received by the API
    @IBAction func didTapeConvertButton() {
        guard sum.text != "", sum.text != "," else {
            alert(title: "Erreur", message: "Aucun montant saisis")
            return
        }
        hideButton(button: convertButton, activityIndicator: rateActivityIndicator)
        currency.getRate { (success, rate) in
            guard success == true else {
                //self.alert(title: "Erreur", message: "Erreur reseau")
                return
            }
            self.convert(rate: rate!)
        }
    }
    
    // Displays the result of the conversion
    private func convert(rate: Float) {
        let result = convertCurrency(sum: sum.text!, rate: rate)
        let convertedRate: String = convertToString(value: rate)
        refreshScreen(text: result, textView: self.result)
        refreshScreen(text: convertedRate, textView: self.rate)
        displayButton(button: convertButton, activityIndicator: rateActivityIndicator)
    }
    
    // Returns the result of the euro dollar conversion as a character string
    private func convertCurrency(sum: String, rate: Float) -> String {
        let convertedSum: Float = currency.convert(sum: sum)
        guard convertedSum != 0 else {
            return "0"
        }
        return convertToString(value: convertedSum * rate)
    }
    
}
