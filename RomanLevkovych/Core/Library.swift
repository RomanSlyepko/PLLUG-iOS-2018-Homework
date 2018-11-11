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
    private var history = [Book: [History]]()
    
    struct History {
        let date: Date
        let owner: String
    }
    
    init(name: String, books: Book...) {
        self.name = name
        self.fond = Set<Book>(books)
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
    
    func getAll() -> [Book] {
        return Array(self.fond)
    }
    
    func available() -> [Book] {
        return self.history.reduce([], { part, value -> [Book] in
            return part + ((value.value.last?.owner == self.name) ? [value.key] : [])
        })
    }
    
    func taken() -> [(Book, String)] {
        return self.history.reduce([]) { (acc, data) -> [(Book, String?)?] in
                guard let lastHistoryEntity = data.value.last else { return acc }
            
                let date = Date()
                let interval = date.timeIntervalSince(lastHistoryEntity.date)
                let format = DateComponentsFormatter()
                format.allowedUnits = [.day, .hour, .minute, .second]
            
                return  acc + [( lastHistoryEntity.owner != self.name ? (data.key, format.string(from: interval)) : nil )]
            }.compactMap { $0 as? (Book, String) }
    }
}