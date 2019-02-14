//
//  Currency.swift
//  Baluchon
//
//  Created by Marques Lucas on 23/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation

// Stock give them from the Fixer.io API
struct Currency: Decodable {
    let rates: [String: Float]
}
