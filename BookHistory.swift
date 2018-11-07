import Foundation

class BookHistory{
    public var _name:String
    public var _date:Date
    init() {
        _name=""
        _date = Date()
    }
    init(name:String,date:Date) {
        _name=name
        _date=date
    }
}
