import Foundation

enum TypeOfBook: String{
    case Book = "Book"
    case Magazine = "Magazine"
    case Newspaper = "Newspaper"
}
class Book {
    var uuid: Int
    var name: String
    var author: String
    var type: TypeOfBook?
    var bookHistory: BookHistory
    init(){
        uuid = 0
        name = ""
        author = ""
        bookHistory = BookHistory()
    }
    init(uuid:Int, name:String, author:String, type:TypeOfBook){
        self.uuid = uuid
        self.name = name
        self.author = author
        self.type = type
        self.bookHistory = BookHistory()
    }
    func getMovingHistory (){
        print("\(String(describing: bookHistory.name)) \(String(describing: bookHistory.date))")
    }
    func Print(){
        print("\(self.name)\t\t\t \(self.author)")
    }
}

extension Book: Hashable {
    static func == (left : Book , right: Book) -> Bool{
        return left.name == right.name && left.uuid == right.uuid && left.author == right.author && left.type == right.type;
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(name)
        hasher.combine(author)
        hasher.combine(type)
    }
}

/*extension Book: Equatable {
 static func == (left : Book , right: Book) -> Bool{
 return left._name == right._name && left._uuid == right._uuid && left._author == right._author && left._type == right._type;
 }
 }*/
