//
//  ResultsPage.swift
//  SongKick
//
//  Created by Roman on 12/9/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

struct ResultsPage: Codable {
    var results: Results?
    var totalEntries: Int
    var page: Int
    var perPage: Int

    
    enum CodingKeys: String, CodingKey {
        case results
        case totalEntries
        case page
        case perPage
    }
}
