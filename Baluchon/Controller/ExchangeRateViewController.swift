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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var result: UITextView!
    @IBOutlet weak var rate: UITextView!
    
    var currency = ExchangeRate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sum.resignFirstResponder()
    }
    
    @IBAction func didTapeConvertButton() {
        guard sum.text != "" else {
            alert(title: "Erreur", message: "Aucun montant saisis")
            return
        }
        displayButton(button: true, activityIndicator: false)
        currency.getRate { (success, rate) in
            guard success == true else {
                self.alert(title: "Erreur", message: "erreur reseau")
                return
            }
            self.convert(rate: rate!)
        }
    }
    
    private func convert(rate: Float) {
        let result = currency.convertCurrency(sum: sum.text!, rate: rate)
        let convertedRate: String = currency.convertToString(value: rate)
        refreshSreen(result: result, rate: convertedRate)
        displayButton(button: false, activityIndicator: true)
    }
    
    private func refreshSreen(result: String, rate: String) {
        self.result.text = result
        self.rate.text = rate
    }
    
    private func displayButton(button: Bool, activityIndicator: Bool) {
        convertButton.isHidden = button
        self.activityIndicator.isHidden = activityIndicator
    }
    
}
