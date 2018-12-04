//
//  List.swift
//  hw_Weather
//
//  Created by user on 11/23/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct List: Codable {
    let dataForecast: Double
    //let main: Mains?
    let weather: [Weathers]
    let clouds: Cloud
    let wind: Wind
    //let snow: Rain
    let system: Syst
    let data: String
    //let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case weather, clouds, wind
        case data = "dt_txt"
        case dataForecast = "dt"
        case system = "sys"
    }
}
