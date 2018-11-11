//
//  main.swift
//  First_homework
//
//  Created by macos on 11/4/18.
//  Copyright © 2018 macos. All rights reserved.
//

import Foundation
extension String {
    var byWords: [String] {
        var byWords:[String] = []
        enumerateSubstrings(in: startIndex..<endIndex, options: .byWords) {
            guard let word = $0 else { return }
            print($1,$2,$3)
            byWords.append(word)
        }
        return byWords
    }
    
    var lastWord: String {
        return byWords.last ?? ""
    }
}
enum TypeBook{
    case Science
    case History
    case Biographies
    case Comics
    case Art
    case Travel
    case Math
    case Default
}

class Book{
    private (set) var uuid: String = UUID().uuidString
    let title: String
    let author: String
    let type: TypeBook?
    var HistoryOfMoving: [Date: String]
    
    init(){
        
        title = ""
        author = ""
        type = TypeBook.Default
       HistoryOfMoving = [Date: String]()
    }
    
    init( title: String, author: String,
         type: TypeBook?, HistoryOfMoving: [Date: String] =
        [Date: String]()){
        self.title = title
        self.author = author
        self.type = type
        self.HistoryOfMoving = HistoryOfMoving
    }
    func getBookInfo(){
        print("Book's Title: \(title),\nBook's author: \(author), \nBook's type: \(type ?? TypeBook.Default), \nBook's uuid: \(uuid)")
    }
    func getHistoryOfMovingofbook()
    {
        print("History of \(self.title) /'s moving")
        for key in self.HistoryOfMoving.keys.sorted(){
            guard let value = self.HistoryOfMoving[key]
                else {break}
            print("\(key) : \(value)")}    }
}


class Reader{
    let name: String
    var BooksOfReader: [Book]
    
    init(name: String, BooksOfReader: [Book] = [Book]())
    {
        self.name = name
        self.BooksOfReader = BooksOfReader
    }
    
}
class Library{
   private var AllBooks = [Book]()
   private var BookInStocks = [Book]()
   var Accounting: [Date: String]
  
    init()
    {
        AllBooks = []
        BookInStocks = []
        Accounting = [:]
        
    }
    func getAllBooks() -> [Book]{
        return AllBooks
    }
    
    func getBookInStocks() -> [Book]{
        return BookInStocks
    }
    
    func getAllBookByType(type: TypeBook){
        print("All books by \(type)")
        for book in AllBooks{
            
            if(book.type == type){
                print("\(book.title)")}
        }
        
    }
    func getBookInStockByType(type: TypeBook){
        print("Books in stock by \(type)")
        for book in BookInStocks{
            if(book.type == type){
                print("\(book.title)")}
        }
        
    }
    func getBooksInUsers(){
        for book in AllBooks
        { var exist = false
            for bookInstock in BookInStocks
            {
                if(book.uuid == bookInstock.uuid)
                { exist = true
                   break
                }
            }
            if(!exist)
            {
    
                if let lastDate = book.HistoryOfMoving.keys.sorted().last {
                    let difference = Calendar.current.dateComponents([.second,.minute,.hour,.day,.month,.year], from: lastDate, to: Date())
                    if let lastvalue = book.HistoryOfMoving[lastDate]
                    { let NameOfUser = lastvalue.components(separatedBy: " ").last
                        if let NameOfUser = NameOfUser
                        {
                        print(" '\(book.title)' took \(NameOfUser) \(difference.day ?? 0) day \(difference.second ?? 0) seconds ago ")}
                        
                    }
                }
          
                }
                }
            }
    
    
    func addBook(book: Book){
        if let index = AllBooks.lastIndex(where: { (allbooks) -> Bool in
        return allbooks.uuid == book.uuid
            })
        {print("This book ( \(book.title) ) is already in library")}
        else{
        AllBooks.append(book)
            BookInStocks.append(book)}
    }
    
    func getBookFromLibrary(book: Book, reader: Reader, date: Date = Date())throws{
        guard let index = BookInStocks.lastIndex(where: { (bookstock) -> Bool in
            return bookstock.uuid == book.uuid
        }) else {throw Failure(message: "\(reader.name) can not get book(Book is not in stock)")}
        
        BookInStocks.remove(at: index)
        book.HistoryOfMoving [date] = "From library to \(reader.name)"
        Accounting [date] = "\(book.title) go to \(reader.name)"
        reader.BooksOfReader.append(book)
    }
    
    
    func tryToGetBookFromLibrary(book: Book, reader: Reader, date: Date = Date())
    {
        do{
            try self.getBookFromLibrary(book: book, reader: reader)
            print("Congratulation! \(reader.name) got a book \(book.title).Happy reading! ")
        } catch(let error)
        {print("\(error)")
            
        }    }
    
    func returnBookFromUser(book: Book, reader: Reader, date: Date = Date())throws{
        guard let index = reader.BooksOfReader.lastIndex(where: { (bookreader) -> Bool in
            return bookreader.uuid == book.uuid
        }) else {throw Failure(message: "Book is not in \(reader.name) s book")}
    
        
        book.HistoryOfMoving [date] = "From \(reader.name) to library"
        Accounting [date] = "\(book.title) return to library by \(reader.name)"
        BookInStocks.append(book)
        reader.BooksOfReader.remove(at: index)
    }
    
    func tryToReturnBookToLibrary(book: Book, reader: Reader, date: Date = Date()) {
        
            do{
                try self.returnBookFromUser(book: book, reader: reader)
                print("\(reader.name) return a book \(book.title).Thank you")}
            catch(let error)
            {print("\(error)")
                
        }
        
    }
    func getAccounting()
    {
        print("History of accounting in library")
        for key in self.Accounting.keys.sorted(){
            guard let value = self.Accounting[key]
                else {break}
            print("\(key) : \(value)")}    }}


struct Failure: Error{
    let message: String
}

let mathanalysis = Book(title: "MathematicalAnalysis", author: "Fichtengolts", type: TypeBook.Math)
let historyRome = Book(title: "A History of Ancient Rome", author: "Mary Beard", type: TypeBook.History)
let onTheRoad = Book(title: "On the Road" , author: "Jack Keroual", type: TypeBook.Travel)
let girlEarning = Book(title: "Girl with a pearl Earning", author: "Tracy Cheralier", type: TypeBook.Art)
let HamiltonBiog = Book(title: "Alexander Hamilton", author: "Ron Chernow", type: TypeBook.Biographies)
let catwComic = Book(title: "Catwoman", author: "Ed Brubaker", type: TypeBook.Comics)
let astronomy = Book(title: "Bad astronomy", author: "Philip Plait", type: TypeBook.Science)

    //mathanalysis.getBookInfo()

let library = Library()

library.addBook(book: mathanalysis)
library.addBook(book: onTheRoad)
library.addBook(book: girlEarning)
library.addBook(book: HamiltonBiog)
library.addBook(book: historyRome)
library.addBook(book: catwComic)
library.addBook(book: astronomy)

// add the same book

library.addBook(book: onTheRoad)
print()
//all books in library
print("All Books in Library")
let all = library.getAllBooks()
all.forEach({print("-",$0.title) })
print()
let reader1 = Reader(name: "Kate")
let reader2 = Reader(name: "Natalie")
let reader3 = Reader(name: "John")

//all.forEach({$0.getBookInfo()})

//give a book from library
library.tryToGetBookFromLibrary(book: mathanalysis, reader: reader1)

sleep(2)
print()
//return book to library
library.tryToReturnBookToLibrary(book: mathanalysis, reader: reader1)
print()
library.tryToGetBookFromLibrary(book: mathanalysis, reader: reader2)
print()
//try to get unavailable book
library.tryToGetBookFromLibrary(book: mathanalysis, reader: reader3)
sleep(3)
//try to return unavailable book
library.tryToReturnBookToLibrary(book: onTheRoad, reader: reader2)

print()
let instockbooks = library.getBookInStocks()
print("Books in stock")
instockbooks.forEach({print("-",$0.title) })
print()
//all books by type

library.getAllBookByType(type: TypeBook.Travel)
print()
//available books by type
library.getBookInStockByType(type: TypeBook.Art)

print("---------------------")

//books in users
print("Books is in users")
library.getBooksInUsers()
print("---------------------")
//history moving of book

mathanalysis.getHistoryOfMovingofbook()

print("---------------------")

//history in library

library.getAccounting()
