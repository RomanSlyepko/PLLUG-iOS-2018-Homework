//
//  Venue.swift
//  SongKick
//
//  Created by user on 12/25/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct Venue: Codable {
    let id: Int?
    let displayName: String
    let uri: String?
    let metroArea: MetroArea
    let lat, lng: Double?
}
