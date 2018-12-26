//
//  Start.swift
//  songKick
//
//  Created by Denys White on 12/25/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

struct Start: Codable {
    
    var date: Date?
    var datetime: Date?
    
    var stringDate: String? {
        return DateManager.string(from: date, type: .onlyDateToDisplay)
    }
    
    var stringFullDate: String? {
        return DateManager.string(from: datetime, type: .fullToDisplay)
    }
    
    enum CodingKeys: String, CodingKey {
        case date
        case datetime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var dateAtRaw = try container.decodeIfPresent(String.self, forKey: .date)
        date = DateManager.date(from: dateAtRaw, type: .onlyDateFromServer)
        dateAtRaw = try container.decodeIfPresent(String.self, forKey: .datetime)
        datetime = DateManager.date(from: dateAtRaw, type: .fullFromServer)
    }
}
