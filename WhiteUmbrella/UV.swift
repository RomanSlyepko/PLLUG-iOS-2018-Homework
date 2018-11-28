//
//  UV.swift
//  WhiteUmbrella
//
//  Created by Denys White on 11/28/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

struct UV: Codable{
    var date : String
    var value : Double
    
    enum CodingKeys: String, CodingKey{
        case date = "date_iso"
        case value
    }
}
