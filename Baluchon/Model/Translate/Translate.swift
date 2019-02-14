//
//  Translate.swift
//  Baluchon
//
//  Created by Marques Lucas on 22/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation

class Translate {
    
    private var url = URL(string: "https://translation.googleapis.com/language/translate/v2?")! // Stock the URL of the API
    private var translateSession: URLSession // Stock a URLSessions
    private var task: URLSessionDataTask? // Stock a URLSessionsDataTask
    
    private var source: String = "fr" // Source message language
    private var target: String = "en" // Target message language
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
    // Send a request to the Google Translate API and return this response
    func translate(Index: Int, text: String, callback: @escaping (Bool, String?) -> Void) {
        let request = createTranslateRequest(text: text, language: Index)
        task?.cancel()
        task = translateSession.dataTask(with: request!) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Translation.self, from: data),
                    let textTranslated = responseJSON.data.translations[0].translatedText else {
                        print("Erreur")
                        callback(false, nil)
                        return
                }
                callback(true, textTranslated)
            }
        }
        task?.resume()
    }
    
    // Create a request based on the received parameter
    private func createTranslateRequest(text: String, language: Int) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let q: String = text
        selectedLanguage(language: language)
        
        let body = "q=\(q)" + "&\(source)" + "&target=\(target)" + "&key=AIzaSyCLxPMNtOFPxzNnDZmnP-IDpfZCGteQIyI"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    // Modify source and target according to received index
    private func selectedLanguage(language: Int) {
        switch language {
        case 0:
            source = "source=fr"
            target = "en"
        case 1:
            source = "source=en"
            target = "fr"
        case 2:
            source = "detect"
            target = "fr"
        default:
            print("erreur selectedLanguage")
        }
    }
}
