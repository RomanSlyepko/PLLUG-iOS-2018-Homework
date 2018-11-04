//
//  AddBookVC.swift
//  Library
//
//  Created by Denys White on 10/31/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class AddBookVC: UIViewController {

    @IBOutlet weak var finishView: UIView!
    
    var fieldsTVC: AddBookTVC?
    
    var library = Library()
    
    var newBook = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        let value = (keyboardFrame.size.height)*(-1.0)
        
        newConstrain(identifier: "bookKB", const: value)
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        newConstrain(identifier: "bookKB", const: 0)
    }
    
    @IBAction func done(_ sender: Any) {
        if let book = fieldsTVC?.book{
            newBook = book
            print(newBook.bookName)
            print(newBook.authorName)
            print(newBook.type)
            print(newBook.dateOfPublishing)
        }
        if newBook.bookName.isEmpty {
            alert(title: "Enter book name", message: "Book name text area is empty", button: "Try Again", action: nil)
        }else{
            if newBook.authorName.isEmpty {
                alert(title: "Enter author name", message: "Author name text area is empty", button: "Try Again", action: nil)
            }else{
                if(newBook.dateOfPublishing == String()){
                    alert(title: "Choose date of publishing", message: "Date of publishing isn't selected", button: "Try Again", action: nil)
                }else{
                    if(newBook.type == Type.notIdentified){
                        alert(title: "Choose type of book", message: "Type of book isn't selected", button: "Try Again", action: nil)
                    }else{
                            library.addBook(book: newBook)
                            showDone()
                    }
                }
            }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pair"{
            if let destination = segue.destination as? AddBookTVC {
                destination.library = library
                fieldsTVC = destination
            }
        }
        if let destination = segue.destination as? BookListVC{
            destination.library = library
        }
    }

}
