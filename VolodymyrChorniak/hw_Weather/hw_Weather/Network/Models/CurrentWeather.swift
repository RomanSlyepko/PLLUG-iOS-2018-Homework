//
//  CurrentWeather.swift
//  hw_Weather
//
//  Created by user on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Winds
    let clouds: Clouds
    let rain: Rains?
    let dt: Double
    let sys: Sys
    let id: Double
    let name: String
    let cod: Double
}

struct Clouds: Codable {
    let all: Double
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Main: Codable {
    let temp: Double
    let pressure, humidity: Double
    let tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Rains: Codable {
    let the3H: Double
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct Sys: Codable {
    let type, id: Double
    let message: Double
    let country: String
    let sunrise, sunset: Double
}

struct Weather: Codable {
    let id: Double
    let main, description, icon: String
}

struct Winds: Codable {
    let speed: Double
    let deg: Double
}

