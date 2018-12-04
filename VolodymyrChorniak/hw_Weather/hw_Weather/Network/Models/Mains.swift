//
//  Mains.swift
//  hw_Weather
//
//  Created by user on 11/23/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct Mains: Codable {
    let temparature, tempMin, tempMax, pressure: Double?
    let seaLevel, groundLevel: Double
    let humidity: Double
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temparature = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}
