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

//    init(from decode: Decoder) throws {
//        let container = try decode.container(keyedBy: CodingKeys.self)
//        dump(container.allKeys[0].rawValue)
//        self.artist = try container.decodeIfPresent([Artist].self, forKey: .artist)
//        dump(artist)
//        self.event = try container.decodeIfPresent([Event].self, forKey: .event)
//    }
    #warning("the answer for dynamic detecting object is container.allKeys - there are all the presented values. THe only thing left - how to actually detect what type I need")
    enum CodingKeys: String, CodingKey {
        case artist
        case event
    }
}

struct Event: Codable {
    var id: Int?
    var name: String?
    var type: String?
    var startDate: StartDate?
    var location: Location?
    var venue: Venue?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "displayName"
        case type
        case location
        case startDate = "start"
        case venue
    }
}

struct StartDate: Codable {
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
