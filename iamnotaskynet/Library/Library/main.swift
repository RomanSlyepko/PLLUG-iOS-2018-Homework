import Foundation

enum BookType {
    case book
    case comix
    case magazine
    case newspapper
}

enum UserAction {
    case getting
    case giving
    case returning
}

class Book {
    let UUID: Int
    let title: String
    let author: String
    let type: BookType

    init(id: Int, title: String, author: String, type: BookType) {
        self.UUID = id
        self.title = title
        self.author = author
        self.type = type
    }
    func getUUID() -> Int {return self.UUID}
    func getTitle() -> String {return self.title}
    func getAuthor() -> String {return self.author}
    func getType() -> BookType {return self.type}
}

class UserInfo {
    let userId: Int //= 1
    let passportCode: String //= "LIBRARY"
    let firsName: String //= "LIBRARY"
    let lastName: String //= "LIBRARY"
    
    //When initializing new UserInfo instance
    init(id: Int, psCode: String, first: String, last: String) {
        self.userId = id
        self.passportCode = psCode
        self.firsName = first
        self.lastName = last
    }
    //Inintializing UserInfo with empty constructor
    //is for library admnistration as a UserInfo
    init() {
        self.userId = 1
        self.passportCode = "LIBRARY"
        self.firsName = "LIBRARY"
        self.lastName = "LIBRARY"
    }
}

class JournalRecord {
    let bookUUID: Int
    var history: [Date: Int] // datetime : userId
    var isInLib: Bool
    
    init(bookUUID: Int, history: [Date: Int], isInLib: Bool) {
        self.bookUUID = bookUUID
        self.history = history
        self.isInLib = isInLib
    }
    
    func getBookUUID () -> Int {return self.bookUUID}
    func getHistory() -> [Date: Int] {return self.history}
    func getIsInLib() -> Bool {return self.isInLib}
    
    func editRecord(userId: Int, isInLib: Bool) {
        self.history.updateValue(userId, forKey: Date())
        self.isInLib = isInLib
    }
}

final class Journal {
    static var journalInstance = Journal( )
    
    var journalRecords = [JournalRecord]()
    
    init(){
        let libraryAsUser = 1 //UserInfo()
        let initialRecord = JournalRecord(bookUUID: 1,
                                          history: [Date(): libraryAsUser],
                                          isInLib: true)
        self.journalRecords.insert(initialRecord, at:0)
    }
    
    func addNewRecord(bookUUID: Int, userID: Int) -> Void {
        let record = JournalRecord(bookUUID: bookUUID, history: [Date(): userID], isInLib: true)
        self.journalRecords.append(record)
    }
    
    func editOldRecord(bookUUID: Int, user: UserInfo, isInLib: Bool ) {
        for record in self.journalRecords {
            let existedBookUUID = record.getBookUUID()
            if existedBookUUID == bookUUID {
                record.editRecord(userId: user.userId, isInLib: isInLib)
            }
        }
    }
    
    func showAllRecords() {
        var result = ""
        print("Journal records:")
        for record in self.journalRecords {
            let bookUUID = record.getBookUUID()
            let history = record.getHistory()
            let isInLib = record.getIsInLib()
            result += "\n \(bookUUID) \t \(history) \t \(isInLib)"
        }
        print(result)
    }
}
//Singleton because we should have only one library to work with
final class Library {
    //Singleton declaration
    static var libraryInstance = Library()
    
    private var firstBook = Book(id:1,
                                 title: "Swift. Основы разработки приложений под iOS и macOS",
                                 author: "Василий Усов",
                                 type: BookType.book)
    
    var arrayOfBooks: [Book] = []
    var arrayOfUsers: [UserInfo] = []
    var journal = Journal()
    
    
    init(){
        arrayOfBooks.insert(firstBook, at: 0)
        arrayOfUsers.insert(UserInfo(), at: 0)
    }
    
    func showAllBooks() {
        var result = ""
        print("All books:\n")
        for book in self.arrayOfBooks {
            let id = book.getUUID()
            let title = book.getTitle()
            let author = book.getAuthor()
            let type = book.getType()
            //print("\(value)")
            result += "\t\(id) \n"
            result += "\t\(title) \n"
            result += "\t\(author) \n"
            result += "\t\(type) \n"
            result += "\t-----------------\n"
        }
        print(result)
    }
    
    func showAllBooksIsInLib() {
        var booksIds: [Int] = []
        for record in journal.journalRecords {
            if record.isInLib {
                booksIds.append(record.bookUUID)
            }
        }
        // print all available books
        print("Available books:\n")
        for book in arrayOfBooks {
            if booksIds.contains(book.UUID){
                print("\t\(book.UUID) \t\(book.title) \t\(book.author) \t\(book.type)\n")
            }
        }
        
    }
    
    func showAllBooksIsNotInLib(){
        var booksIds: [Int] = []
        for record in journal.journalRecords {
            if !record.isInLib {
                booksIds.append(record.bookUUID)
            }
        }
        // print all unavailable books
        print("Unavailable books:\n")
        for book in arrayOfBooks {
            if booksIds.contains(book.UUID){
                print("\t\(book.UUID) \t\(book.title) \t\(book.author) \t\(book.type)\n")
            }
        }
    }
    
    func addNewBook(book: Book, user: UserInfo) {
        //checking by id is book ever been in library
        for existedBook in self.arrayOfBooks {
            if existedBook.getUUID() == book.getUUID() {
                return
            }
        }
        //checking is user info in Library
        for existedUser in self.arrayOfUsers {
            if existedUser.userId == user.userId {
                self.arrayOfBooks.append(book)
                self.journal.addNewRecord(bookUUID: book.getUUID(), userID: user.userId)
            }
        }
    }
    
    func giveBookToUser(userId: Int, bookId: Int) {
        for user in self.arrayOfUsers {
            if user.userId == userId {
                for book in self.arrayOfBooks {
                    if book.UUID == bookId {
                        for record in self.journal.journalRecords {
                            if record.bookUUID == bookId && record.isInLib {
                                //TODO: edit
                                record.editRecord(userId: userId, isInLib:false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func giveBookBackFromUser(userId: Int, bookId: Int) {
        for user in self.arrayOfUsers {
            if user.userId == userId {
                for book in self.arrayOfBooks {
                    if book.UUID == bookId {
                        for record in self.journal.journalRecords {
                            if record.bookUUID == bookId && !record.isInLib {
                                //TODO: edit
                                record.editRecord(userId: userId, isInLib:true)
                            }
                        }
                    }
                }
            }
        }    }
    
    func addUserInfo(user: UserInfo) {
        for existedUser in self.arrayOfUsers {
            if existedUser.userId == user.userId {
                return
            }
        }
        self.arrayOfUsers.append(user)
    }
    
    func showAllUsers() {
        for user in self.arrayOfUsers {
            print("ID: \(user.userId) PP: \(user.passportCode) FN: \(user.firsName) LN: \(user.lastName)")
        }
    }
}

var library = Library()

let userInstance = UserInfo(id: 2, psCode: "12345", first: "Iamnota", last: "Skynet")

library.addUserInfo(user: userInstance)

//library.showAllUsers()
//print(library.showAllBooks())
//print(library.journal.showAllRecords())

let sicpBook = Book(id: 2, title: "SICP", author: "G.J.S. & H.A.", type: .book)

library.addNewBook(book: sicpBook, user: userInstance)

//library.showAllBooks()
//library.journal.showAllRecords()

library.giveBookToUser(userId: userInstance.userId, bookId: 1)

//library.journal.showAllRecords()

library.giveBookBackFromUser(userId: userInstance.userId, bookId: 1)

//library.journal.showAllRecords()

let gofBook = Book(id: 3, title: "GoF", author: "4 of them", type: .book)

library.addNewBook(book: gofBook, user: userInstance)

library.giveBookToUser(userId: userInstance.userId, bookId: 2)

library.showAllBooksIsInLib()

library.showAllBooksIsNotInLib()

library.showAllBooks()

library.journal.showAllRecords()
