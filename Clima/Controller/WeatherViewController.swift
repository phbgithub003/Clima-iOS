//
//  ViewController.swift
//  Clima
//
//  Created by Harshit on 09/02/2024.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    
    var weatherManger = WeatherManager(delegate: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManger.delegate = self
        searchTF.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTF.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTF.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if searchTF.text != "" {
            return true
        } else {
            searchTF.placeholder = "Type Something"
            return false
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTF.text{
            weatherManger.getCityWeather(city)
        }
        
        searchTF.text = ""
    }
}

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    
}
