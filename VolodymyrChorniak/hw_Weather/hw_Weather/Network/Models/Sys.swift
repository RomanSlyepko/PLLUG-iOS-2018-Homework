//
//  Sys.swift
//  hw_Weather
//
//  Created by user on 11/23/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct Sys: Codable {
    let type, id: Double
    let message: Double
    let country: String
    let sunrise, sunset: Double
}
