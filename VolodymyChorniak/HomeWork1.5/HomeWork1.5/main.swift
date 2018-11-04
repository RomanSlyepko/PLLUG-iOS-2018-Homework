//
//  main.swift
//  HomeWork1.5
//
//  Created by user on 11/1/18.
//  Copyright © 2018 Chorniak inc. All rights reserved.
//

import Foundation

class Book {
    var uId: String
    var bookName: String
    var bookAuthor: String
    var bookType: BookType
    var currentUser: String?
    
    init(id: String, name: String, author: String, type: BookType) {
        self.uId = id
        self.bookName = name
        self.bookAuthor = author
        self.bookType = type
    }
}

enum BookType: String {
    case Fiction
    case Scientific
    case Technical
}

struct Failure: Error {
    let message: String
}

class DateInfo {
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let date = Date()
        let dateStr = formatter.string(from: date)

        return dateStr
    }
    
    func timeDifferenceBetweenNowAnd(time: String) -> Double{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let timeInDateFormat = formatter.date(from: "\(time)")
        
        //sleep(2)    // Use to emulate a time delay. +2 sec for every next user.
        
        let currentTime =  self.getCurrentTime()
        let currentDateTime = formatter.date(from: "\(currentTime)")
        let timeDifferent  = currentDateTime!.timeIntervalSince(timeInDateFormat!)
        
        return timeDifferent
    }
    
}

func getRandomID() -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0...4).map{ _ in letters.randomElement()! })
}


var dateInfo = DateInfo()

var book1 = Book(id: getRandomID(), name: "Codding for profi", author: "Roma Coder", type: .Technical)
var book2 = Book(id: getRandomID(), name: "Kak podnyat babla", author: "Viktor Automat", type: .Scientific)
var book3 = Book(id: getRandomID(), name: "Great Again", author: "Donald Tramp", type: .Fiction)
var book4 = Book(id: getRandomID(), name: "Swift book", author: "Apple", type: .Technical)
var book5 = Book(id: getRandomID(), name: "Frankenstein", author: "Mary Shelley", type: .Fiction)
var book6 = Book(id: getRandomID(), name: "It", author: "Stephen King", type: .Scientific)
var book7 = Book(id: getRandomID(), name: "Test", author: "Author", type: .Scientific)
var book8 = Book(id: getRandomID(), name: "Test2", author: "Author2", type: .Scientific)

class Library {
    var booksInLibrary = [book1, book2, book3, book4]
    var availableBooks = [book1, book2, book3, book4]
    var libraryHistoy = [LibHistory]()
    
    struct LibHistory {
        var userName: String?
        var book: Book
        var time: String
        var action: ActionType
    }
    
    enum ActionType: String {
        case addNewBook = "New book in library"
        case takeBookFromLibrary = "take book from library"
        case giveBackBookFromLibrary = "give back book to library"
    }
    
    
    func addBook(book: Book) throws {
        guard booksInLibrary.firstIndex(where: {$0.bookName == book.bookName}) == nil else {
            throw Failure(message: "We already have this book in our library")
        }
        
        print("NEW! We haw the new book in library: \"\(book.bookName)\" by \(book.bookAuthor)\n")
        booksInLibrary.append(book)
        availableBooks.append(book)
    }
    
    func giveBookForUser(book: Book, userName: String) throws {
        print("Hello, I'm \(userName). Please give me \"\(book.bookName)\"")
        
        guard let index = availableBooks.lastIndex(where: { (bookAviable) -> Bool in
            return bookAviable.uId == book.uId
        }) else {
            throw Failure(message: "Sorry \(userName), this is book not aviable")
        }
        
        libraryHistoy.append(Library.LibHistory.init(userName: userName, book: book, time: dateInfo.getCurrentTime(), action: .takeBookFromLibrary))
        print("Take your book \(userName)\n")
        availableBooks.remove(at: index)
        book.currentUser = userName
    }
    
    func takeBookFromUser(book: Book, userName: String) throws {
        print("Hello, it's me, \(userName), I come to give back your book \"\(book.bookName)\"")

        guard userName == book.currentUser else {
            throw Failure(message: "We can not take this book from you\n")
        }
        
        print("Hello \(userName), thanks\n")
        libraryHistoy.append(Library.LibHistory.init(userName: userName, book: book, time: dateInfo.getCurrentTime(), action: .giveBackBookFromLibrary))
        availableBooks.append(book)
        book.currentUser = nil
    }
    
    
}

var library = Library()

// MARK: - Library controller

class libraryController {
    
    func addBookToLibrary(book: Book) {
        do {
            try library.addBook(book: book)
        } catch (let error) {
            print("\(error)\n")
        }
    }
    
    func userTakeBookFromLibrary(book: Book, userName: String) {
        do {
            try library.giveBookForUser(book: book, userName: userName)
        } catch (let error) {
            print("\(error)\n")
        }
    }
    
    func userGiveBackBookToLibrary(book: Book, userName: String) {
        do {
            try library.takeBookFromUser(book: book, userName: userName)
        } catch (let error) {
            print("\(error)\n")
        }
    }
    
    func printBookInUsers() {
        print("All books in users:")
        for index in library.libraryHistoy {
            if index.userName == index.book.currentUser {
                let timeDifferent = dateInfo.timeDifferenceBetweenNowAnd(time: index.time)
                print("\(index.book.bookName) in \(index.userName!) from \(index.time). He (she) take it \(timeDifferent) seconds ago")
            }
        }
        print()
    }
    
    func printBookInUsersByType(type: BookType) {
        print("\(type.rawValue) books in users:")
        for index in library.libraryHistoy {
            if index.book.bookType == type, index.userName == index.book.currentUser {
                let timeDifferent = dateInfo.timeDifferenceBetweenNowAnd(time: index.time)
                print("\(index.book.bookName) in \(index.userName!) from \(index.time). He (she) take it \(timeDifferent) seconds ago")
            }
        }
        print()
    }
    
    func printLibHistory() {
        print("Library history:")
        for index in library.libraryHistoy {
            print("\(index.time) - \(index.userName ?? "") \(index.action.rawValue): \"\(index.book.bookName)\" by \(index.book.bookAuthor)")
        }
        print()
    }
    
    func printBooksByAvailability(bookArray: [Book]) {
        for index in bookArray {
            print("\"\(index.bookName)\" by \(index.bookAuthor)")
        }
        print()
    }
    
    func printAllBookByTypeAndAvailability(type: BookType, bookArray: [Book]) {
        for index in bookArray {
            if index.bookType == type {
                print("\"\(index.bookName)\" by \(index.bookAuthor)")
            }
        }
        print()
    }
    
    func printMoveHistoryForBook(book: Book) {
        print("Move history for \"\(book.bookName)\"")
        for index in library.libraryHistoy {
            if index.book.uId == book.uId {
                print("\(index.time) - \(index.userName!) \(index.action.rawValue)")
            }
        }
        print()
    }
    
    
}

let libController = libraryController()


// MARK: - Test


// Add new book to library
libController.addBookToLibrary(book: book5)
// Add an existing book to the library
libController.addBookToLibrary(book: book5)

// User take the book from the library:
libController.userTakeBookFromLibrary(book: book1, userName: "Alex")
// User tries to take an unavailable book:
libController.userTakeBookFromLibrary(book: book1, userName: "Alex")
// User tries to return the book that the other user has taken:
libController.userGiveBackBookToLibrary(book: book1, userName: "Niko")
// Book in library, user tries return this book:
libController.userGiveBackBookToLibrary(book: book2, userName: "Donald")
// User tries to return his book:
libController.userGiveBackBookToLibrary(book: book1, userName: "Alex")
// User take returned book from library:
libController.userTakeBookFromLibrary(book: book1, userName: "Carl")
// User take new (added) book from library:
libController.userTakeBookFromLibrary(book: book5, userName: "Jack")
// The same user take anouther book:
libController.userTakeBookFromLibrary(book: book4, userName: "Jack")
// User tries to give a book which is not in the library
libController.userGiveBackBookToLibrary(book: book6, userName: "John")

// Library history:
libController.printLibHistory()
// Move history for book (book1):
libController.printMoveHistoryForBook(book: book1)

// All avilable books:
print("All available books:")
libController.printBooksByAvailability(bookArray: library.availableBooks)
// Avilable technical books:
print("Aviable scientific books:")
libController.printAllBookByTypeAndAvailability(type: .Scientific, bookArray: library.availableBooks)
// Fiction books in library:
print("All fiction books in library:")
libController.printAllBookByTypeAndAvailability(type: .Fiction, bookArray: library.booksInLibrary)
// All books in library:
print("All books in library:")
libController.printBooksByAvailability(bookArray: library.booksInLibrary)
// All books in users:
libController.printBookInUsers()
// Technical books in users:
libController.printBookInUsersByType(type: .Technical)




