import Foundation

class Library {
    var existingBooks: Set<Book>
    var availableBooks: Set<Book>
    var absentBooks: Set<Book>
    init (){
        existingBooks = Set<Book>()
        availableBooks = Set<Book>()
        absentBooks = Set<Book>()
    }
    func addBook(book:Book){
        existingBooks.insert(book)
        availableBooks.insert(book)
    }
    func isBookAvailable(book: Book) -> Bool{
        return availableBooks.contains(book)
    }
    func takeBook(book:Book,name:String){
        if(availableBooks.contains(book)){
            let date:Date = Date()
            book.bookHistory = BookHistory(Name:name,Date:date)
            absentBooks.insert(book)
            availableBooks.remove(book)
        }
        else{
            print("currently this book is not available")
        }
    }
    func acceptBook(book:Book){
        let date:Date = Date()
        book.bookHistory = BookHistory(Name:"",Date:date)
        availableBooks.insert(book)
        absentBooks.remove(book)
    }
}
