import Foundation

var Biblioteka:Library = Library()
var Graphics:PseudoGraphics = PseudoGraphics()
var Kobzar:Book = Book(uuid:1,name:"Kobzar",author:"Shevchenko",type:.Book)
var Times:Book = Book(uuid:2,name:"Times",author:"NewYork",type:.Newspaper)
var Forbes:Book = Book(uuid:3,name:"Forbes",author:"USA",type:.Magazine)

Biblioteka.AddBook(book: Kobzar)
Biblioteka.AddBook(book: Times)
Biblioteka.AddBook(book: Forbes)

Biblioteka.TakeBook(book: Kobzar, name: "Ivan")
Biblioteka.TakeBook(book: Forbes, name: "Stariy")

Biblioteka.AcceptBook(book: Kobzar)

Graphics.Output(lib:Biblioteka)
