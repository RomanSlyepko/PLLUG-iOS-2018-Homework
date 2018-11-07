import Foundation

class Library {
    var ebookList: Set<Book>
    var abookList: Set<Book>
    var nbookList: Set<Book>
    init (){
        ebookList = Set<Book>()
        abookList = Set<Book>()
        nbookList = Set<Book>()
    }
    func AddBook(book:Book){
        ebookList.insert(book)
        abookList.insert(book)
    }
    func isBookAvailable(book: Book) -> Bool{
        return abookList.contains(book)
    }
    func TakeBook(book:Book,name:String){
        if(abookList.contains(book)){
            let date:Date = Date()
            book._bookHistory = BookHistory(name:name,date:date)
            nbookList.insert(book)
            abookList.remove(book)
        }
        else{
            print("currently this book is not available")
        }
    }
    func AcceptBook(book:Book){
        let date:Date = Date()
        book._bookHistory = BookHistory(name:"",date:date)
        abookList.insert(book)
        nbookList.remove(book)
    }
}
