//
//  BookInfoVC.swift
//  Library
//
//  Created by Denys White on 10/30/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class BookInfoVC: UIViewController {

    @IBOutlet weak var typeOfAct: UIButton!
    
    var library = Library()
    var book = Book()
    var bookHistory = [History]()
    var k = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookHistory = book.History
        
        if book.isRented {
            typeOfAct.setTitle("Return a book", for: .normal)
        }else{
            typeOfAct.setTitle("Isuue a book", for: .normal)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookInfoTVC{
            destination.book = book
        }
        if let destination = segue.destination as? BookHistoryVC{
            destination.library = library
            destination.bookHistory = bookHistory
            destination.book = book
        }
        if let destination = segue.destination as? BookListVC{
            destination.library = library
            destination.k = k
        }
        if let destination = segue.destination as? BookActionVC{
            destination.book = book
            destination.library = library
        }
    }

}
