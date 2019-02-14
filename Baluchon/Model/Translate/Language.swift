//
//  Lang.swift
//  Baluchon
//
//  Created by Marques Lucas on 30/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation

// The structure of this file makes it possible to store the Google Translate API data
struct Translation: Decodable {
    let data: TranslationData
}

struct TranslationData: Decodable {
    let translations: [TranslationText]
}

struct TranslationText: Decodable {
    let translatedText: String?
}

let language: [String] = ["Français > Anglais", "Anglais > Français", "Detection > Français"] // Stock the different value of UIPickerView
