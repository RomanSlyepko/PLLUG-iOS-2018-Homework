//
//  Identifier.swift
//  SongKick
//
//  Created by user on 12/7/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct Identifier: Codable {
    let mbid: String
    let href, eventsHref, setlistsHref: String
}
