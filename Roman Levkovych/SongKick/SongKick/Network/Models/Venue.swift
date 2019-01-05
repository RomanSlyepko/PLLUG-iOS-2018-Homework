//
//  Venue.swift
//  SongKick
//
//  Created by Roman on 12/27/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

struct Venue: Codable {
    var id: Int?
    var name: String?
    var latitude: Double?
    var longtitude: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "displayName"
        case latitude = "lat"
        case longtitude = "lng"
    }
}
