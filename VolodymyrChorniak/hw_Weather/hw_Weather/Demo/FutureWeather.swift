//
//  FutureWeather.swift
//  hw_Weather
//
//  Created by user on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

// The data model may vary depending on the city, so I use the optional values

struct FutureWeather: Codable {
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [List]?
    let city: City?
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordi?
    let country: String
    let population: Int
}

struct Coordi: Codable {
    let lat, lon: Double
}

struct List: Codable {
    let dt: Int
    let main: MainClass?
    let weather: [Weathers?]
    let clouds: Cloud?
    let wind: Wind?
    let sys: Syst?
    let dtTxt: String
    let rain, snow: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, snow, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

struct Cloud: Codable {
    let all: Int
}

struct MainClass: Codable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double
    let humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Rain: Codable {
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct Syst: Codable {
    let pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

struct Weathers: Codable {
    let id: Int
    let main: MainEnum?
    let description: Description?
    let icon: String
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case lightSnow = "light snow"
    case scatteredClouds = "scattered clouds"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

struct Wind: Codable {
    let speed, deg: Double
}
