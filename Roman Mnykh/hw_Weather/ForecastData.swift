//
//  ForecastData.swift
//  hw_Weather
//
//  Created by Roman Mnykh on 11/29/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation

struct ForecastData: Codable {
    let city: CityModel
    //let coordinates: GeolocationModel
    //let country: String
    let cod: String
    let message: Double
    let numberOfReturnedLines: Int
    let list: [ListModel]
    
    enum CodingKeys: String, CodingKey {
        case city
        //case coordinates = "coord"
        //case country
        case cod
        case message
        case numberOfReturnedLines = "cnt"
        case list
    }
}

struct CityModel: Codable {
    let id: Int
    let name: String
}

struct ListModel: Codable {
    let dt: Int64
    let main: MainForecastModel
    let weather: [WeatherModel]
    let clouds: CloudModel
    let wind: WindModel
    let system: SystemForecastModel
    let dataTimeText: String
    
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case system = "sys"
        case dataTimeText = "dt_txt"
    }
}

struct MainForecastModel: Codable {
    let temp: Double
    let minTemp: Double
    let maxTemp: Double
    let pressure: Double
    let seaLevel: Double
    let groundLevel: Double
    let humidity: Int
    let tempKF: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity
        case tempKF = "temp_kf"
    }
}

struct SystemForecastModel: Codable {
    let pod: String
}


