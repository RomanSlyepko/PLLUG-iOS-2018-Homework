//
//  Artists.swift
//  SongKick
//
//  Created by Roman on 12/9/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

struct Artist: Codable {
    var id : Int?
    var displayName : String?
    var url : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case displayName = "displayName"
        case url = "uri"
    }
    
}
