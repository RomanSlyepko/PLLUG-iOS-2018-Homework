//
//  FutureWeather.swift
//  hw_Weather
//
//  Created by user on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation


struct FutureWeather: Codable {
    let code: String
    let message: Double
    let count: Double
    let list: [List]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case message, list, city
        case code = "cod"
        case count = "cnt"
    }
}
