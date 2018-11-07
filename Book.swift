import Foundation

enum TypeOfBook: String{
    case Book = "Book"
    case Magazine = "Magazine"
    case Newspaper = "Newspaper"
}
class Book {
    var _uuid: Int
    var _name: String
    var _author: String
    var _type: TypeOfBook?
    var _bookHistory: BookHistory
    init(){
        _uuid = 0
        _name = ""
        _author = ""
        _bookHistory = BookHistory()
    }
    init(uuid:Int, name:String, author:String, type:TypeOfBook){
        self._uuid = uuid
        self._name = name
        self._author = author
        self._type = type
        self._bookHistory = BookHistory()
    }
    func getMovingHistory (){
        print("\(String(describing: _bookHistory._name)) \(String(describing: _bookHistory._date))")
    }
    func Print(){
        print("name: \(self._name) author: \(self._author)")
    }
}

extension Book: Hashable {
    static func == (left : Book , right: Book) -> Bool{
        return left._name == right._name && left._uuid == right._uuid && left._author == right._author && left._type == right._type;
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(_uuid)
        hasher.combine(_name)
        hasher.combine(_author)
        hasher.combine(_type)
    }
}

/*extension Book: Equatable {
 static func == (left : Book , right: Book) -> Bool{
 return left._name == right._name && left._uuid == right._uuid && left._author == right._author && left._type == right._type;
 }
 }*/
