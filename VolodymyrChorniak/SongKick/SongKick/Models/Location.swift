//
//  Location.swift
//  SongKick
//
//  Created by user on 12/25/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct Location: Codable {
    let city: String
    let lat, lng: Double?
}
