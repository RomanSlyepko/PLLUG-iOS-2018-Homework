//
//  BookActionVC.swift
//  Library
//
//  Created by Denys White on 10/31/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class BookActionVC: UIViewController {

    @IBOutlet weak var finishView: UIView!
    @IBOutlet weak var borrowerTextField: UITextField!
    @IBOutlet weak var bookInfoLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var issueDateLabel: UILabel!
    
    
    var library = Library()
    var book = Book()
    
    func setup(){
        bookInfoLabel.text = "\(book.bookName)\nby \(book.authorName)"
        if book.isRented {
            issueDateLabel.text = "Issued on: \(book.History.last!.date)\nby: \(book.History.last!.borrower)"
            borrowerTextField.isHidden = true
            titleLabel.text = "Return"
            titleImage.image = #imageLiteral(resourceName: "Back")
        }else{
            issueDateLabel.isHidden = true
            titleLabel.text = "Issue"
            titleImage.image = #imageLiteral(resourceName: "Issue")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    func showDone(){
        var runCount = Int8()
        finishView.isHidden = false
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runCount += 1
            print(runCount)
            if runCount == 1 {
                timer.invalidate()
                self.performSegue(withIdentifier: "Done", sender: self)
            }
        }
    }
    
    @IBAction func done(_ sender: Any) {
        if book.isRented {
            library.returnBook(book: book)
            showDone()
        }else{
            if borrowerTextField.text?.isEmpty == false {
                let borrower = borrowerTextField.text!
                library.rentBook(book: book, borrower: borrower)
                showDone()
            }else{alert(title: "Enter name of borrower", message: "Text area is empty", button: "Try again", action: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookInfoVC{
            destination.book = book
            destination.library = library
        }
    }

}
