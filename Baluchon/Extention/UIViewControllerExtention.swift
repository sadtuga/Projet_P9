//
//  UIViewControllerExtention.swift
//  Baluchon
//
//  Created by Marques Lucas on 22/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Show a custom alert based on title and message received
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // Convert the received parameter to a string
    func convertToString(value: Float) -> String {
        return String(value)
    }
    
    // Display the received UIButton and hide the UIActivityIndicatorView
    func displayButton(button: UIButton, activityIndicator: UIActivityIndicatorView) {
        button.isHidden =  false
        activityIndicator.isHidden = true
        
    }
    
    // Display the UIActivityIndicatorView and hide the UIButton received
    func hideButton(button: UIButton, activityIndicator: UIActivityIndicatorView) {
        button.isHidden =  true
        activityIndicator.isHidden = false
    }
    
    // Applies the text received to a UITextView
    func refreshScreen(text: String, textView: UITextView) {
        textView.text = text
    }
    
    @objc func networkError() {
        alert(title: "Erreur réseau!", message: "Vérifier votre connexion!")
    }
    
    @objc func incorrectServerResponse() {
        alert(title: "Réponse serveur incorrect!", message: "Le serveur a renvoyé une erreur!")
    }
    
    @objc func dataUnreadable() {
        alert(title: "Data illisible!", message: "Les donner reçu n'est pas utilisable!")
    }
}
