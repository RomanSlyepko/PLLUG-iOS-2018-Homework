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
    let cod: String
    let message: Double
    let cnt: Double
    let list: [List]
    let city: City
}

struct City: Codable {
    let id: Double
    let name: String
    let coord: Coordi
    let country: String
    let population: Double
}

struct Coordi: Codable {
    let lat, lon: Double
}

struct List: Codable {
    let dt: Double
    let main: Mains?
    let weather: [Weathers]
    let clouds: Cloud
    let wind: Wind
    let snow: Rain
    let sys: Syst
    let dtTxt: String
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, snow, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

struct Cloud: Codable {
    let all: Double
}

struct Mains: Codable {
    let temp, tempMin, tempMax, pressure: Double?
    let seaLevel, grndLevel: Double
    let humidity: Double
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
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

struct Weathers: Codable {
    let id: Double
    let main: MainEnum
    let description: Description
    let icon: String
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case lightRain = "light rain"
    case lightSnow = "light snow"
    case scatteredClouds = "scattered clouds"
    case snow = "snow"
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

/*
struct FutureWeather: Codable {
    let cod: String
    let message: Double
    let cnt: Double
    let list: [List]
    let city: City
}

struct City: Codable {
    let id: Double
    let name: String
    let coord: Coordi
    let country: String
    let population: Double
}

struct Coordi: Codable {
    let lat, lon: Double
}

struct List: Codable {
    let dt: Double
    let main: Mains
    let weather: [Weathers]
    let clouds: Cloud
    let wind: Wind
    let snow: Rain
    let sys: Syst
    let dtTxt: String
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, snow, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

struct Cloud: Codable {
    let all: Double
}

struct Mains: Codable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double
    let humidity: Double
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
    let pod: Pod
}

struct Pod: Codable {
    let d: String
    let n: String
}

struct Weathers: Codable {
    let id: Double
    let main: MainEnum
    let description: Description
    let icon: String
}

struct Description: Codable {
    let brokenClouds: String
    let clearSky: String
    let lightRain: String
    let lightSnow: String
    let scatteredClouds: String
    let snow: String
}

struct MainEnum: Codable {
    let clear: String
    let clouds: String
    let rain: String
    let snow: String
}

struct Wind: Codable {
    let speed, deg: Double
}
*/
