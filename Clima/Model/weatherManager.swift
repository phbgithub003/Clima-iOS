//
//  weatherManager.swift
//  Clima
//
//  Created by Harshit Bhargava  on 12/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct weatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?appid={openweathermap_appid}&units=metric&q="
    
    func getCityWeather(_ city :String) {
        let urlString = "\(url)\(city)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlSting :String){
        guard let url = URL(string: urlSting) else{
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            if error != nil{
                print(error!)
                return
            }
            if let data = data{
                parseJson(weatherData: data)
            }
        }
        task.resume()
        
    }
    
    func parseJson(weatherData: Data ) {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodeData.main.temp)
            print(decodeData.weather[0].description)
        } catch {
            print(error)
        }
    }
    
}
