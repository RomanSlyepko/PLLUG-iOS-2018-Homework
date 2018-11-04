//
//  AddBookTVC.swift
//  Library
//
//  Created by Denys White on 10/31/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class AddBookTVC: UITableViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var bookNameTF: UITextField!
    @IBOutlet weak var authorNameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateButtonShow: UIButton!
    @IBOutlet weak var typeButtonShow: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    var library = Library()
    var book = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        print("TVS SAY:")
        print(book.type)
        print(book.dateOfPublishing)
        print("---------------")
    }
    
    func setup(){
        bookNameTF.delegate = self
        authorNameTF.delegate = self
        picker.delegate = self
        picker.dataSource = self
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        bookNameTF.addTarget(self, action: #selector(bookNameDidChange(_:)), for: .editingChanged)
        authorNameTF.addTarget(self, action: #selector(authorNameDidChange(_:)), for: .editingChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Type.allCases.count-1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Type.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeButtonShow.setTitle(Type.allCases[row].rawValue, for: .normal)
        typeButtonShow.isHidden = false
        let bookType = Type.allCases[row].rawValue
        book.type = Type(rawValue: bookType)!
        print(book.type)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.string(from: datePicker.date)
        book.dateOfPublishing = date
        print(book.dateOfPublishing)
        dateButtonShow.setTitle(date, for: .normal)
        dateButtonShow.isHidden = false
    }
    
    @IBAction func datePress(_ sender: Any) {
        dateButtonShow.isHidden = true
    }
    
    @IBAction func typePress(_ sender: Any) {
        typeButtonShow.isHidden = true
    }
    
    @objc func bookNameDidChange(_ textField: UITextField) {
        book.bookName = bookNameTF.text!
        print(book.bookName)
    }
    
    @objc func authorNameDidChange(_ textField: UITextField) {
        book.authorName = authorNameTF.text!
        print(book.authorName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddBookVC{
            destination.library = library
            destination.newBook = book
        }
    }

}
