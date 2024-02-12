//
//  weatherManager.swift
//  Clima
//
//  Created by Harshit Bhargava  on 12/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct weatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=f4a5f97f24d0c6402a149e64c5ce59f1&units=metric&q="
    
    func getCityWeather(_ city :String) {
        let urlString = "\(url)\(city)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlSting :String){
        guard let url = URL(string: urlSting) else{
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: URLRequest(url: url), completionHandler: {data,response,error in
            if error != nil{
                print(error!)
                return
            }
            if let data = data{
                let dataString = String(data: data, encoding: .utf8)
                print(dataString)
            }
        } )
        task.resume()
        
    }

}
