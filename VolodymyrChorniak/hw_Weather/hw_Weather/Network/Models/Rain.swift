//
//  Rain.swift
//  hw_Weather
//
//  Created by user on 11/23/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

struct Rain: Codable {
    let rainLast3Hours: Double?
    
    enum CodingKeys: String, CodingKey {
        case rainLast3Hours = "3h"
    }
}
