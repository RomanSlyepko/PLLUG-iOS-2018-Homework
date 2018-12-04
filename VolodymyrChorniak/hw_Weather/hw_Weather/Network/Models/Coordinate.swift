//
//  Coordinate.swift
//  hw_Weather
//
//  Created by user on 11/23/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct Coordinate: Codable {
    let latitude, longtitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longtitude = "lon"
    }
}
