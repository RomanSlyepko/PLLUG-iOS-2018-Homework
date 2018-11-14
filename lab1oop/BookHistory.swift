import Foundation

class BookHistory{
    public var name:String
    public var date:Date
    init() {
        name=""
        date = Date()
    }
    init(Name:String,Date:Date) {
        name=Name
        date=Date
    }
}
