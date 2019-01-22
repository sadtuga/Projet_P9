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
    
    var rateView = ExchangeRateView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sum.resignFirstResponder()
    }
    
    @IBAction func convert() {
        if sum.text == "" {
            alert(title: "Erreur", message: "Aucun montant saisis")
        } else {
            convertButton.isHidden = true
            activityIndicator.isHidden = false
        }
    }
}
