//
//  CurrentWeather.swift
//  hw_Weather
//
//  Created by user on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    let coordinates: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Winds
    let clouds: Clouds
    let rain: Rains?
    let date: Double
    let sys: Sys
    let id: Double
    let name: String
    let code: Double
    
    enum CodingKeys: String, CodingKey {
        case weather, base, main, wind, clouds, rain, sys, id, name
        case coordinates = "coord"
        case date = "dt"
        case code = "cod"
    }
}

