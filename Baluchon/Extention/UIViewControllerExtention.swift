//
//  UIViewControllerExtention.swift
//  Baluchon
//
//  Created by Marques Lucas on 22/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}