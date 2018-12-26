//
//  Artist.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

struct Artist: Codable {
    
    var displayName = String()
    
}

extension Artist: Equatable{
    
    static func ==(lhs: Artist, rhs: Artist) -> Bool {
        return lhs.displayName == rhs.displayName
    }
    
}
