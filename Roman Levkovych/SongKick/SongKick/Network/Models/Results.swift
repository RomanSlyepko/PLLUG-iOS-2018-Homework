//
//  Results.swift
//  SongKick
//
//  Created by Roman on 12/9/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

struct Results: Codable {
    var artist : [Artist]?
    
    enum CodingKeys: String, CodingKey {
        case artist = "artist"
    }
}
