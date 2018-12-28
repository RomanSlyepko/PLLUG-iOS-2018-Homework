//
//  Artist.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

struct Artist: Codable {
    
    var id: Int
    var displayName: String
    var identifier: [Identifier]
    var onTourUntil: Date?
    
    var onTourUntilString: String? {
        return DateManager.string(from: onTourUntil, type: .onlyDateToDisplay)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName
        case identifier
        case onTourUntil
    }
    
    init(from decoder: Decoder) throws{
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        displayName = try container.decode(String.self, forKey: .displayName)
        identifier = try container.decode([Identifier].self, forKey: .identifier)
        let onTourUntilString = try container.decode(String?.self, forKey: .onTourUntil)
        onTourUntil = DateManager.date(from: onTourUntilString, type: .onlyDateFromServer)
    }
}

extension Artist: Equatable{
    
    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.id == rhs.id
    }
    
}
