//
//  Book.swift
//  Levkovych
//
//  Created by Roman on 11/3/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

struct Book {
    let name: String
    let author: String
    let publisher: String
    let genre: Genres
    let type: Literature
}

extension Book: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.author)
        hasher.combine(self.publisher)
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        var lhash = Hasher()
        var rhash = Hasher()
        lhs.hash(into: &lhash)
        rhs.hash(into: &rhash)
        return lhash.finalize() == rhash.finalize()
    }
    
    var hashValue: Int {
        var hash = Hasher()
        self.hash(into: &hash)
        return hash.finalize()
    }
}

extension Book: Equatable {
    static func !=(lhs: Book, rhs: Book) -> Bool {
        return lhs == rhs
    }
}

//extension Book: Codable {
//    init(from decoder: Decoder) throws {
//        <#code#>
//    }
//
//    func encode(to encoder: Encoder) throws {
//        <#code#>
//    }
//    
//    private enum CodingKeys: CodingKey {
//        
//    }
//    
//}
