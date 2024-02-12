//
//  weatherData.swift
//  Clima
//
//  Created by Harshit Bhargava  on 12/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Array]
    
}

struct Main :Decodable {
    let temp: Double
}

struct Array:Decodable {
    let id: Int

}
