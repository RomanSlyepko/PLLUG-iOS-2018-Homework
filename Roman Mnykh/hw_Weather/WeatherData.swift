//
//  WeatherData.swift
//  hw_Weather
//
//  Created by Roman Mnykh on 11/24/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let coordinates: GeolocationModel
    let weather: [WeatherModel]
    let base: String
    let visibility: Int
    let wind: WindModel
    let clouds: CloudModel
    let dt: Int64
    let system: SystemModel
    let id: Int64
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather
        case base
        case visibility
        case wind
        case clouds
        case dt
        case system = "sys"
        case id
        case name
        case cod
    }
    
}

struct GeolocationModel: Codable {
    let longtitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longtitude = "lon"
        case latitude = "lat"
    }
}

struct WeatherModel: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
}

struct MainModel: Codable {
    let temperature: Double
    let pressure: Int
    let humidity: Int
    let minTemperature: Double
    let maxTemperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure
        case humidity
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
    }
}

struct WindModel: Codable {
    let speed: Double
    let degree: Double
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}

struct CloudModel: Codable {
    let all: Int
}

struct SystemModel: Codable {
    let type: Int
    let id: Int
    let message: Double
    let country: String
    let sunrise: Int64
    let sunset: Int64
}



