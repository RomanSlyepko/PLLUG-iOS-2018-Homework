//
//  main.swift
//  Levkovych
//
//  Created by Roman on 11/3/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation


let book0 =  Book(id: 0, name: "Swift", author: "Apple", publisher: "O'Reilly", genre: .Education, type: .Book)
let book1 = Book(id: 0, name: "name1", author: "author1", publisher: "publisher1", genre: .Action, type: .Book)
let book2 = Book(id: 0, name: "name2", author: "author3", publisher: "publisher1", genre: .Horror, type: .Magazine)
let book3 = Book(id: 0, name: "JS", author: "Apple", publisher: "O'Reilly", genre: .Education, type: .Newspaper)

let lib = Library(name: "Library", books: book0, book1, book2, book3)


do {
    try lib.take(book: book1, to: "Roman Levkovych")
    Thread.sleep(until: Date(timeIntervalSinceNow: 69))
} catch { print(error.localizedDescription) }

    print("Available:\n\n")
    print(lib.available())
    print("-------------------------------------------------------------")
    print("Taken:\n\n")
    print(lib.taken())

do {
    try lib.getBack(book: book1)
} catch { print(error.localizedDescription) }



