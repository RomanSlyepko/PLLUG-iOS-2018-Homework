//
//  Future.swift
//  WhiteUmbrella
//
//  Created by Denys White on 11/28/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

struct Future: Codable {
    var list : [Page]
}

struct Page: Codable {
    var weather : [Weather]
    var main : Main
    var wind : Wind
    var clouds : Clouds
    var date : String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case wind
        case clouds
        case date = "dt_txt"
    }
}
