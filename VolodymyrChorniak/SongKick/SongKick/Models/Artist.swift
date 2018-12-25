//
//  Artist.swift
//  SongKick
//
//  Created by user on 12/7/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct Artist: Codable {
    let id: Int
    let displayName: String
    let uri: String
    let identifier: [Identifier]
    let onTourUntil: String?
}

extension Artist: Equatable {
    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.id == rhs.id
    }
}
