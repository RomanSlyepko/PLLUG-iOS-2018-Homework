//
//  Event.swift
//  SongKick
//
//  Created by user on 12/25/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct Event: Codable {
    let id: Double
    let displayName: String
    let uri: String
    let status: String
    let popularity: Double
    let start: End
    let performance: [Performance]
    let flaggedAsEnded: Bool
    let venue: Venue
    let location: Location
    let end: End?
    let series: Series?
}
