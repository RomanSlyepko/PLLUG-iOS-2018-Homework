//
//  LibraryClass.swift
//  Library
//
//  Created by Denys White on 10/29/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation
import UIKit

func generateRandomDate()-> String{
    
    let day = arc4random_uniform(15000)
    
    let today = Date(timeIntervalSinceNow: 0)
    let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    var offsetComponents = DateComponents()
    offsetComponents.day = Int(day)
    
    let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    
    return dateFormatter.string(from: randomDate!)
}

func gen()->String{
    return UUID().uuidString
}

func strDate()->String{
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter.string(from: date)
}

enum HistoryType: String{
    case In = "Return"
    case Out = "Issue"
}

class History {
    var borrower : String
    var date : String
    var type : HistoryType
    
    init(borrower: String, type: HistoryType){
        self.borrower = borrower
        self.type = type
        self.date = generateRandomDate()
    }
}

enum Type: String, CaseIterable{
    case Book = "Book"
    case Magazine = "Magazine"
    case NewsPaper = "NewsPaper"
    case Manga = "Manga"
    case notIdentified = "notIdentified"
}

class Book:Hashable{
    
    var bookName = String()
    var authorName = String()
    var dateOfPublishing = String()
    var type = Type.notIdentified
    var UUID = gen()
    var isRented = Bool()
    var History : [History] = []
    var hashValue : Int {
        return UUID.hashValue
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.UUID == rhs.UUID
    }
    
    init(bookName:String, authorName : String, dateOfPublishing: String, type : Type){
        self.bookName = bookName
        self.authorName = authorName
        self.dateOfPublishing = dateOfPublishing
        self.type = type
        self.isRented = false
        self.History = []
    }
    
    init(){}
    
}

class Library{
    var allBooks = [Book]()
    
    func sort(sortedСoefficient: Int)->[Book]{
        
        var resultArray = [Book]()
        
        if sortedСoefficient == 0{
            resultArray = allBooks
        }
        if sortedСoefficient == 1{
            resultArray = allBooks.filter({ book -> Bool in
                book.isRented == false
            })
        }
        if sortedСoefficient == 2{
            resultArray = allBooks.filter({ book -> Bool in
                book.isRented == true
            })
        }
        
        return resultArray
        
    }
    
    func addBook(book: Book){
        allBooks.append(book)
    }
    
    func removeBook(book: Book){
        var bookIndex = Int()
        for i in 0 ..< allBooks.count{
            if allBooks[i].UUID == book.UUID{
                bookIndex = i
            }
        }
        print("-------------------")
        print(allBooks[bookIndex].bookName)
        print("-------------------")
        allBooks.remove(at: bookIndex)
        for i in 0 ..< allBooks.count{
            print(allBooks[i].bookName)
        }
    }
    
    func rentBook(book: Book, borrower: String){
        let history = History(borrower: borrower, type: HistoryType.Out)
        book.History.append(history)
        book.isRented = true
    }
    
    func returnBook(book: Book){
        let borrower = book.History.last?.borrower
        let history = History(borrower: borrower!, type: HistoryType.In)
        book.History.append(history)
        book.isRented = false
    }
    
    func gen(){
        self.allBooks = [
            Book(bookName: "Steve Jobs", authorName: "Walter Isaacson", dateOfPublishing: "24.10.2011", type: Type.Book),
            Book(bookName: "Hamlet", authorName: "William Shakespeare", dateOfPublishing: "01.08.2005", type: Type.Book),
            Book(bookName: "Kobzar", authorName: "Taras Shevchenko", dateOfPublishing: "26.04.1840", type: Type.Book),
            Book(bookName: "Oyasumi Punpun", authorName: "Inio Asano", dateOfPublishing: "15.03.2007", type: Type.Manga),
            Book(bookName: "Ruslan and Ludmila", authorName: "Alexander Pushkin", dateOfPublishing: "01.10.2000", type: Type.Book),
            Book(bookName: "Forbes", authorName: "Forbes Publishing Company", dateOfPublishing: "15.06.1917", type: Type.Magazine),
            Book(bookName: "Komsomolskaya Pravda", authorName: "Izdatelsky Dom Komsomolskaya Pravda", dateOfPublishing: "24.05.1925", type: Type.NewsPaper),
            Book(bookName: "Harry Potter and the Philosopher's Stone", authorName: "J. K. Rowling", dateOfPublishing: "26.06.1997", type: Type.Book),
            Book(bookName: "A Game of Thrones", authorName: "George R. R. Martin", dateOfPublishing: "01.08.1996", type: Type.Book),
            Book(bookName: "Crime and Punishment", authorName: "Fyodor Dostoevsky", dateOfPublishing: "22.08.2001", type: Type.Book)
        ]
    }
    
}
