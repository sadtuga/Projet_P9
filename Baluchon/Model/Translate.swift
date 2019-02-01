//
//  Translate.swift
//  Baluchon
//
//  Created by Marques Lucas on 22/01/2019.
//  Copyright © 2019 Marques Lucas. All rights reserved.
//

import Foundation

class Translate {
    
    private var url = URL(string: "https://translation.googleapis.com/language/translate/v2?")!
    private var translateSession: URLSession
    private var task: URLSessionDataTask?
    
    private var source: String = "fr"
    private var target: String = "en"
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
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
    
    private func createTranslateRequest(text: String, language: Int) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let q: String = text
        selectedLanguage(language: language)
        
        let body = "q=\(q)" + "&\(source)" + "&target=\(target)" + "&key=AIzaSyCLxPMNtOFPxzNnDZmnP-IDpfZCGteQIyI"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
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
