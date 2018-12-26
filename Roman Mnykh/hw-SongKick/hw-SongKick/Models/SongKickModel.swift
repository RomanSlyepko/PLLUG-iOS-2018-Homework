//
//  ArtistModel.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/7/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation

struct SongKickModel: Codable {
    let resultsPage: ResultsPageModel
}

struct ResultsPageModel: Codable {
    let status: String
    let results: ResultModel
    let perPage: Int
    let page: Int
    let totalEntries: Int
}

struct ResultModel: Codable {
    let artist: [ArtistModel]?
    let event: [EventModel]?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case event
    }
}

struct EventModel: Codable {
    let id: Int
    let displayName: String
    let location: LocationModel
    let venue: VenueModel
}

struct ArtistModel: Codable {
    let id: Int
    let displayName: String
    //let URI: String
    //let identifier: [IdentifierModel]
    let onTourUntil: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName
        //case URI = "uri"
        //case identifier
        case onTourUntil
    }
    
}

struct IdentifierModel: Codable {
    let mbid: String
    let href: String
    let eventsHref: String
    let setlistsHref: String
}

struct LocationModel: Codable {
    let city: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case city
        case longitude = "lng"
        case latitude = "lat"
    }
}

struct VenueModel: Codable {
    let displayName: String
}
