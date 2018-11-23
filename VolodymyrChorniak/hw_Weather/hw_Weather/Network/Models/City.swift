//
//  City.swift
//  hw_Weather
//
//  Created by user on 11/23/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct City: Codable {
    let id: Double
    let name: String
    let coordinate: Coordinate
    let country: String
    let population: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, country, population
        case coordinate = "coord"
    }
}
