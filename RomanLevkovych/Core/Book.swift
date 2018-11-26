//
//  Book.swift
//  Levkovych
//
//  Created by Roman on 11/3/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

class Book {
    private(set) var id: Int
    private(set) var name: String
    private(set) var author: String
    private(set) var publisher: String
    private(set) var genre: Genres
    private(set) var type: Literature
    
    init(id: Int,
        name: String,
        author: String,
        publisher: String,
        genre: Genres,
        type: Literature) {
        self.id = id
        self.name = name
        self.author = author
        self.publisher = publisher
        self.genre = genre
        self.type = type
    }
}

extension Book: CustomStringConvertible {
    var description: String {
        return "\(self.name) by \(self.author) with \(self.publisher)"
    }
    
}

extension Book: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
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
    
    static func !=(lhs: Book, rhs: Book) -> Bool {
        return !(lhs == rhs)
    }
}
