//
//  ParsingModels.swift
//  songKick
//
//  Created by Denys White on 12/25/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

//MARK: ResultsPage
struct ResultsPage: Codable {
    var resultsPage: SearchResults
}
//MARK: Identifier
struct Identifier: Codable {
    var eventsHref: String?
}
//MARK: ApiResultsError
struct ApiResultsError: Codable {
    var message: String
}
//MARK: Event
struct Event: Codable {
    var displayName: String
    var type: String
    var start: Start?
    var venue: Venue
    var location: Location
}
//MARK: Venue
struct Venue: Codable {
    var displayName: String
}
//MARK: Location
struct Location: Codable {
    var city: String
    var lat: Double?
    var lng: Double?
}
