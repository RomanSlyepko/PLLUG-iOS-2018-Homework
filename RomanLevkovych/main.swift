//
//  main.swift
//  Levkovych
//
//  Created by Roman on 11/3/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

struct Obs: Observer {
    var id: Int
    
    var book: Book
    
    func update(action: Actions) {
        print(String(describing: book) + " " + action.rawValue)
    }
    
    
}

let book0 =  Book(id: 0, name: "Swift", author: "Apple", publisher: "O'Reilly", genre: .Education, type: .Book)
let book1 = Book(id: 1, name: "name1", author: "author1", publisher: "publisher1", genre: .Action, type: .Book)
let book2 = Book(id: 2, name: "name2", author: "author3", publisher: "publisher1", genre: .Horror, type: .Magazine)
let book3 = Book(id: 3, name: "JS", author: "Apple", publisher: "O'Reilly", genre: .Education, type: .Newspaper)

let lib = Library(name: "Library", books: book0, book1, book2, book3)

let obs = Obs(id: 0, book: book1)
let obs1 = Obs(id: 1, book: book2)
lib.attach(observer: obs)

do {
    try lib.take(book: book1, to: "Roman Levkovych")
    Thread.sleep(until: Date(timeIntervalSinceNow: 2))
    try lib.take(book: book2, to: "Another Owner")
} catch { print(error.localizedDescription) }

    print("Available:\n\n")
    print(lib.available().map { String(describing: $0) })
    print("-------------------------------------------------------------")
    print("Taken:\n\n")
    print(lib.taken())

do {
    try lib.getBack(book: book1)
} catch { print(error.localizedDescription) }



