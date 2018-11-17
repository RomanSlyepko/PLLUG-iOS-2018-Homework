//
//  UltravioletIndexData.swift
//  hw_Weather
//
//  Created by user on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

// The data model may vary depending on the city, so I use the optional values

struct Ultraviolet: Codable {
    let lat, lon: Double?
    let dateISO: String?
    let date: Int?
    let value: Double?
    
    enum CodingKeys: String, CodingKey {
        case lat, lon
        case dateISO = "date_iso"
        case date, value
    } 
}
