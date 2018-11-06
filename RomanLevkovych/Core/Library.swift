//
//  Library.swift
//  Levkovych
//
//  Created by Roman on 11/3/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

class Library {
    
    // MARK: - properties
    let name: String
    private(set) var fond: Set<Book>
    private var history =  [Book: [History]]()
    
    struct History {
        let date: Date
        let owner: String
    }
    
    init(name: String, books: Book...) {
        self.name = name
        self.fond = Set<Book>(books)
        self.history = [Book : [History]]()
        for book in self.fond {
            history[book] = [History(date: Date(), owner: self.name)]
        }
    }
    
    func add(book: Book) throws {
        if self.fond.contains(book) {
            throw LibraryErrors.BookIsInLibrary
        }
        self.fond.insert(book)
        self.history[book] = [History(date: Date(), owner: self.name)]
    }
    
    func take(book: Book, to owner: String) throws {
        if self.fond.contains(book) && self.history[book]?.last?.owner == self.name {
            self.history[book]?.append(Library.History(date: Date(), owner: owner))
        } else {
            throw LibraryErrors.BookIsTaken
        }
    }
    
    func getBack(book: Book) throws {
        if self.fond.contains(book) && self.history[book]?.last?.owner != self.name {
            self.history[book]?.append(Library.History(date: Date(), owner: self.name))
        } else {
            throw LibraryErrors.BookHaveReturned
        }
    }
    
    func filter(by expr: @escaping (Book) -> Bool) -> [Book] {
        return self.fond.filter(expr)
    }
    
    func available() -> [Book] {
        return self.history.reduce([], { part, value -> [Book] in
            return part + ((value.value.last?.owner == self.name) ? [value.key] : [])
        })
    }
    
    func taken() -> [Book] {
        return self.history.reduce([], { part, value -> [Book] in
            return part + ((value.value.last?.owner != self.name) ? [value.key] : [])
        })
    }
}
