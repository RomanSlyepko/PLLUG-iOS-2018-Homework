//
//  Results.swift
//  songKick
//
//  Created by Denys White on 12/28/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

enum Results {
    case artist([Artist])
    case event([Event])
    case unsupported
}

extension Results: Codable {

    private enum ApiType: String{
        case artist
        case event
    }

    private struct CustomCodingKeys: CodingKey {
        var stringValue: String
        init(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
        self = .unsupported

        for key in container.allKeys{
            switch key.stringValue {
            case ApiType.artist.rawValue:
                let value = try container.decode([Artist].self, forKey: CustomCodingKeys(stringValue: key.stringValue))
                self = .artist(value)
            case ApiType.event.rawValue:
                let value = try container.decode([Event].self, forKey: CustomCodingKeys(stringValue: key.stringValue))
                self = .event(value)
            default:
                self = .unsupported
            }
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CustomCodingKeys.self)
        switch self {
        case .artist(let res):
            try container.encode(res, forKey: CustomCodingKeys(stringValue: ApiType.artist.rawValue))
        case .event(let res):
            try container.encode(res, forKey: CustomCodingKeys(stringValue: ApiType.event.rawValue))
        case .unsupported:
            let context = EncodingError.Context(codingPath: [], debugDescription: "Invalid attachment.")
            throw EncodingError.invalidValue(self, context)
        }
    }
}
