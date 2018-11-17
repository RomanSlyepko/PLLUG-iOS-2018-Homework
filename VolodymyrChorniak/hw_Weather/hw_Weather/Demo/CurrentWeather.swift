//
//  CurrentWeather.swift
//  hw_Weather
//
//  Created by user on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

// The data model may vary depending on the city, so I use the optional values

struct CurrentWeather: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let wind: Winds?
    let clouds: Clouds?
    let rain: Rains?
    let dt: Int?
    let sys: Sys?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct Clouds: Codable {
    let all: Int
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Main: Codable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Rains: Codable {
    let the3H: Int
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct Sys: Codable {
    let type, id: Int
    let message: Double
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct Winds: Codable {
    let speed: Double
    let deg: Int
}

