//
//  weatherManager.swift
//  Clima
//
//  Created by Harshit Bhargava  on 12/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}


struct WeatherManager {
    
    let url = "https://api.openweathermap.org/data/2.5/weather?appid={appid}&units=metric&q="
    
    var delegate: WeatherManagerDelegate?
    
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
                if let weather = parseJson(weatherData: data) {
                    delegate?.didUpdateWeather(weather: weather)
                }
            }
        }
        task.resume()
        
    }
    
    func parseJson(weatherData: Data )-> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodeData.main.temp
            let id = decodeData.weather[0].id
            let city = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: city, temperature: temp)
            return weather
             
        } catch {
            print(error)
            return nil
        }
    }
    
}
