//
//  Response.swift
//  SongKick
//
//  Created by Roman on 12/8/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

struct Response: Codable {
    var resultsPage: ResultsPage
    
    enum CodingKeys: String, CodingKey {
        case resultsPage
    }
}
