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
    
    private var currency = ExchangeRate()
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sum.resignFirstResponder()
    }
    
    @IBAction func didTapeConvertButton() {
        guard sum.text != "" else {
            alert(title: "Erreur", message: "Aucun montant saisis")
            return
        }
        hideButton(button: convertButton, activityIndicator: rateActivityIndicator)
        currency.getRate { (success, rate) in
            guard success == true else {
                self.alert(title: "Erreur", message: "erreur reseau")
                return
            }
            self.convert(rate: rate!)
        }
    }
    
    private func convert(rate: Float) {
        let result = convertCurrency(sum: sum.text!, rate: rate)
        let convertedRate: String = convertToString(value: rate)
        refreshScreen(text: result, textView: self.result)
        refreshScreen(text: convertedRate, textView: self.rate)
        displayButton(button: convertButton, activityIndicator: rateActivityIndicator)
    }
    
    private func convertCurrency(sum: String, rate: Float) -> String {
        let convertedSum: Float = currency.convert(sum: sum)
        guard convertedSum != 0 else {
            return "0"
        }
        return convertToString(value: convertedSum * rate)
    }
    
}
