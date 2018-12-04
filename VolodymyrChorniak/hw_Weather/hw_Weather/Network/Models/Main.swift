//
//  Main.swift
//  hw_Weather
//
//  Created by user on 11/23/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct Main: Codable {
    let temparature: Double
    let pressure, humidity: Double
    let tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case pressure, humidity
        case temparature = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
