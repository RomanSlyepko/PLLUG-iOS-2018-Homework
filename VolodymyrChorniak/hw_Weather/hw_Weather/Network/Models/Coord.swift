//
//  Coord.swift
//  hw_Weather
//
//  Created by user on 11/23/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct Coord: Codable {
    let longtitude, latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longtitude = "lon"
        case latitude = "lat"
    }
}
