import UIKit

// -------------------------------------
// MARK: - Book
// -------------------------------------

class Book: Hashable, Equatable, CustomStringConvertible {
    
    var description: String {
        return "\(name)"
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.UUID == rhs.UUID
    }
    
    private let UUID: Int
    let name: String
    let author: String
    enum Format: String {
        case hardback
        case paperback
    }
    let format: Format
    let pageCount: Int
    let edition: Int?
    let dimensions: (length: Int, width: Int, height: Int, weight: Double)?
    
    var hashValue: Int {
        return UUID.hashValue
    }

    init(id: Int, name: String, author: String, format: Format,
                pageCount: Int, edition: Int? = nil,
                dimensions: (Int, Int, Int, Double)? = nil) {
        UUID = id
        self.name = name
        self.author = author
        self.format = format
        self.pageCount = pageCount
        self.edition = edition
        self.dimensions = dimensions
    }
}

enum LibraryError: String, Error {
    case notFound = "Book was not found!"
    case unrecognized = "Book wasn't a library properly!"
    case alreadyExists = "Book already exists in the library!"
    case notAvailable = "Book isn't available!"
}

// -------------------------------------
// MARK: - Library
// -------------------------------------

class Library {
    
    enum Status {
        case available
        case unavailable
        case everything
    }
    
    enum SortOption {
        case byAuthor
        case byName
        case none
    }
    
    // TODO: -DateFormatter
    
    struct HistoryEntry {
        let date: String
        let person: String?
        enum Action: String {
            case borrowed = "Borrowed"
            case returned = "Returned"
        }
        let action: Action
        
        init(on date: String, _ person: String? = nil, _ action: Action) {
            self.date = date
            self.person = person
            self.action = action
        }
        
        init(on date: String, _ action: Action) {
            self.init(on: date, nil, action)
        }
        
    }
    
    private var books: Set<Book> = []
    private var history: [Book:[HistoryEntry]] = [:]
    private var observers: [LibraryObserver] = []
    
    static let shared = Library()
    weak var delegate: LibraryDelegate?
    
    func add(_ book: Book) throws {
        guard !books.contains(book) else { throw LibraryError.alreadyExists }
        books.insert(book)
        notify(book, event: .added)
        delegate?.bookDidAdd(book: book)
    }
    
    func lendBook(_ book: Book, to person: String, on date: String) throws {
        guard books.contains(book) else { throw LibraryError.notFound }
        
        if let historyEntries = history[book], historyEntries.last?.action == .borrowed { throw LibraryError.notAvailable }
        
        let entry = HistoryEntry(on: date, person, .borrowed)
        
        defer {
            history[book]?.append(entry)
            notify(book, event: .lent)
            delegate?.bookDidLend(book: book)
        }
        
        //history[book] = (history[book] != nil) ? history[book] : []
        guard history[book] != nil else { history[book] = []; return }
    }
    
    func returnBook(_ book: Book, on date: String) throws {
        guard books.contains(book) else { throw LibraryError.unrecognized }
        guard let historyEntries = history[book], historyEntries.last?.action != .returned else { throw LibraryError.alreadyExists }
        
        let entry = HistoryEntry(on: date, .returned)
        history[book]?.append(entry)
        notify(book, event: .returned)
        delegate?.bookDidReturn(book: book)
    }
    
    func getListOfBooks(_ status: Status, sorted sortOption: SortOption = .none) {
        var listOfBooks: [Book]
        
        switch status {
        case .available:
            listOfBooks = Array(books.filter { history[$0] == nil || history[$0]?.last?.action != .borrowed })
        case .unavailable:
            listOfBooks = Array(books.filter { history[$0]?.last?.action == .borrowed })
        case .everything:
            listOfBooks = Array(books)
        }
        
        switch sortOption {
        case .byAuthor:
            listOfBooks.sort { $0.author < $1.author }
        case .byName:
            listOfBooks.sort { $0.name < $1.name }
        case .none:
            break
        }
        
        if case .unavailable = status {
            for book in listOfBooks {
                if let currentHolder = history[book]?.last?.person {
                    print("\(book) was taken by \(currentHolder)")
                }
            }
        } else {
            for book in listOfBooks {
                print(book)
            }
        }
        
    }
    
    func showHistory(of book: Book) {
        if let bookHistory = history[book] {
            print("History of \(book):")
            bookHistory.map { entry in
                //let personName = entry.person ?? ""
                let person = (entry.person == nil) ? "" : ("by " + entry.person!)
                print("\(entry.action.rawValue) on \(entry.date) \(person)")
            }
        } else {
            print("\(book) has no recorded history.")
        }
    }
    
    func findAllBooks(by author: String) -> [Book]? {
        let foundBooks: [Book] = books.filter { $0.author == author }
        return !foundBooks.isEmpty ? foundBooks : nil
    }
    
}

extension Library: Observable {
    
    func addObserver(_ observer: LibraryObserver) {
        if observers.contains(where: { $0 === observer } ) == false {
            observers.append(observer)
        }
    }
    
    func removeObserber(_ observer: LibraryObserver) {
        if let index = observers.firstIndex(where: { $0 === observer } ) {
            observers.remove(at: index)
        }
    }
    
    func notify(_ book: Book, event: LibraryEvent) {
        observers.forEach { observer in
            observer.notifyActionDone(book: book, event: event.rawValue)
        }
    }
}

// -------------------------------------
// MARK: - Observable
// -------------------------------------

protocol Observable: class {
    
    func addObserver(_ observer: LibraryObserver)
    func removeObserber(_ observer: LibraryObserver)
    func notify(_ book: Book, event: LibraryEvent)
    
}

enum LibraryEvent: String {
    case lent
    case returned
    case added
}

// -------------------------------------
// MARK: - Observer
// -------------------------------------

protocol LibraryObserver: class {
    func notifyActionDone(book: Book, event: String)
}

// -------------------------------------
// MARK: - Person
// -------------------------------------

class Person: LibraryObserver {
    
    func notifyActionDone(book: Book, event: String) {
        print("Observer: \(book) was \(event)")
    }
    
}

// -------------------------------------
// MARK: - Delegate
// -------------------------------------

protocol LibraryDelegate: class {
    
    func bookDidAdd(book: Book)
    func bookDidLend(book: Book)
    func bookDidReturn(book: Book)
    
}

extension Person: LibraryDelegate {
    
    func bookDidAdd(book: Book) {
        print("Delegate: \(book) was added")
    }
    
    func bookDidLend(book: Book) {
        print("Delegate: \(book) was lent")
    }
    
    func bookDidReturn(book: Book) {
        print("Delegate: \(book) was returned")
    }
    
    func listenForChanges(of library: Library? = nil) {
        if let library = library {
            library.delegate = self
        } else {
            Library.shared.delegate = self
        }
    }
    
}


let book1 = Book.init(id: 123, name: "B TestBook", author: "Ming Lee", format: .hardback, pageCount: 401)
let book2 = Book.init(id: 124, name: "A TestBook Two", author: "Big Chu", format: .hardback, pageCount: 907)

let library = Library()

let person = Person()

library.addObserver(person)
person.listenForChanges(of: library)

do { try library.add(book1)
} catch {
    print(error)
}
do { try library.add(book2)
} catch {
    print(error)
}

//library.getListOfBooks(.available, sorted: .byName)

do { try library.lendBook(book1, to: "Halas", on: "23/07/1992")
} catch {
    print(error)
}

do { try library.returnBook(book1, on: "21/01/1993")
} catch {
    print(error)
}

do { try library.lendBook(book1, to: "Second Halas", on: "26/06/1994")
} catch {
    print(error)
}

//library.getListOfBooks(.available, sorted: .byAuthor)
library.getListOfBooks(.everything)

library.showHistory(of: book1)
library.findAllBooks(by: "Ming Lee")



