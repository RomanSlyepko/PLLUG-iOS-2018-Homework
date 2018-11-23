//
//  Weather.swift
//  hw_Weather
//
//  Created by user on 11/23/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let id: Double
    let main, description, icon: String
}
