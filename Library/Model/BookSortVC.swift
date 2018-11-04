//
//  BookSortVC.swift
//  Library
//
//  Created by Denys White on 11/4/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class BookSortVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    
    var library = Library()
    var bookHistory = [History]()
    var book = Book()
    
    var who : Character = " "
    
    var options = ["No sort","Book Name ↓","Book Name ↑","Author Name ↓","Author Name ↑","Puplished ↓","Published ↑"]
    
    var choise = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        if who == "L"{
            options = ["No sort","Book Name ↓","Book Name ↑","Author Name ↓","Author Name ↑","Puplished ↓","Published ↑"]
        }else{
            options = ["No sort","Reader ↓","Reader ↑","Date ↓","Date ↑"]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choise = row
        print(row)
    }
    
    @IBAction func done(_ sender: Any) {
        if who == "L"{
            performSegue(withIdentifier: "List", sender: self)
        }else{
            performSegue(withIdentifier: "History", sender: self)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        choise = 0
        if who == "L"{
            performSegue(withIdentifier: "List", sender: self)
        }else{
            performSegue(withIdentifier: "History", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookListVC{
            destination.library = library
            destination.k = choise
        }
        if let destination = segue.destination as? BookHistoryVC{
            destination.library = library
            destination.bookHistory = bookHistory
            destination.k = choise
            destination.book = book
        }
    }

}
