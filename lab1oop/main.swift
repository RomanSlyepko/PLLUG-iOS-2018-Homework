import Foundation

var Biblioteka:Library = Library()
var Graphics:PseudoGraphics = PseudoGraphics()
var Kobzar:Book = Book(uuid:1,name:"Kobzar",author:"Shevchenko",type:.Book)
var Times:Book = Book(uuid:2,name:"Times",author:"NewYork",type:.Newspaper)
var Forbes:Book = Book(uuid:3,name:"Forbes",author:"USA",type:.Magazine)

Biblioteka.addBook(book: Kobzar)
Biblioteka.addBook(book: Times)
Biblioteka.addBook(book: Forbes)

Biblioteka.takeBook(book: Kobzar, name: "Ivan")
Biblioteka.takeBook(book: Forbes, name: "Stariy")

Biblioteka.acceptBook(book: Kobzar)

Graphics.Output(lib:Biblioteka)
