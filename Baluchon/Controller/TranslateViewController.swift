//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Marques Lucas on 16/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var translation: UITextView!
    @IBOutlet weak var UIPicker: UIPickerView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translateActivityIndicator: UIActivityIndicatorView!
    
    private var translate = Translate() // Stock the instance of the Translate class
    private var index: Int = 0 // Stock index of UIPickerView
    
    // Removes the keyboard and stores the text entered in the text variable
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        text.resignFirstResponder()
    }

    // Manages the data received by the API
    @IBAction func didTapeTranslateButton(_ sender: Any) {
        index = UIPicker.selectedRow(inComponent: 0)
        hideButton(button: translateButton, activityIndicator: translateActivityIndicator)
        translate.translate(Index: index, text: text.text) { (success, translatedText) in
            if success == true {
                self.refreshScreen(text: translatedText!, textView: self.translation)
            } else {
                self.alert(title: "Erreur", message: "erreur reseau")
            }
        }
        displayButton(button: translateButton, activityIndicator: translateActivityIndicator)
    }

}

extension TranslateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Returns the column number of the UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Returns the number of lines in the UIPickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return language.count
    }
    
    // Returns the value corresponding to the request line of UIPickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return language[row]
    }
}
