//
//  Results.swift
//  SongKick
//
//  Created by Roman on 12/9/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

struct Results: Codable {
    var artist: [Artist]?
    var event: [Event]?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case event
    }
}

struct Event: Codable {
    var id: Int?
    var name: String?
    var type: String?
    var startData: StartData?
    var location: Location?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "displayName"
        case type
    }
}

struct StartData: Codable {
    var date: String?
    var time: String?
    
    enum CodingKeys: String, CodingKey {
        case date
        case time
    }
}

struct Location: Codable {
    var city: String?
    var latitude: Double?
    var longtitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case city
        case latitude = "lat"
        case longtitude = "lng"
    }
}
