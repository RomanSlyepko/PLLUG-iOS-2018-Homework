//
//  UltravioletIndexData.swift
//  hw_Weather
//
//  Created by user on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct Ultraviolet: Codable {
    let lat, lon: Double
    let dateISO: String
    let date: Double
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case lat, lon
        case dateISO = "date_iso"
        case date, value
    } 
}
