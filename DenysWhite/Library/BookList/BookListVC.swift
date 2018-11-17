//
//  BookListVC.swift
//  Library
//
//  Created by Denys White on 10/30/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class BookListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var library = Library()
    var allFiltersArray = [Book]()
    var k = Int()
    
    var selectedBook = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let font = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
        
        allFiltersArray = library.sort(filterСoefficient: f(), sortedСoefficient: k)
        
    }
    
    func f()->Int{
        return segment!.selectedSegmentIndex
    }
    
    func deleteItemFromFilterArray(book: Book){
        var bookIndex = Int()
        for i in 0 ..< allFiltersArray.count{
            if allFiltersArray[i].UUID == book.UUID{
                bookIndex = i
            }
        }
        allFiltersArray.remove(at: bookIndex)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let counter = allFiltersArray.count
        if counter == 0 {
            table.isHidden = true
            return 0
        }else{
            table.isHidden = false
            return counter
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let book = allFiltersArray[indexPath.row]
        
        cell.textLabel?.text = "\(book.bookName)\n"
        if (book.type == Type.Magazine || book.type == Type.NewsPaper || k > 4) && (k != 3 && k != 4) {
            cell.detailTextLabel?.text = "Publishing: \(book.dateOfPublishing)"
        }else{
            cell.detailTextLabel?.text = "by \(book.authorName)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBook = allFiltersArray[indexPath.row]
        performSegue(withIdentifier: "bookInfo", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = allFiltersArray[indexPath.row]
            library.removeBook(book: book)
            deleteItemFromFilterArray(book: book)
        }
        table.reloadData()
    }
    
    @IBAction func segmentTap(_ sender: Any) {
        UIView .performWithoutAnimation {
            table.isHidden = false
            allFiltersArray = library.sort(filterСoefficient: f(), sortedСoefficient: k)
            table.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        allFiltersArray = library.sort(filterСoefficient: f(), sortedСoefficient: k).filter({ book -> Bool in
            if searchText.isEmpty {return true}
            return book.bookName.lowercased().contains(searchText.lowercased()) ||
                book.authorName.lowercased().contains(searchText.lowercased()) ||
                book.dateOfPublishing.lowercased().contains(searchText.lowercased()) ||
                book.type.rawValue.lowercased().contains(searchText.lowercased()) ||
                book.UUID.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        let value = (keyboardFrame.size.height)*(-1.0)
        
        newConstrain(identifier: "scroll", const: value)
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        newConstrain(identifier: "scroll", const: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookInfoVC{
            destination.book = selectedBook
            destination.library = library
            destination.k = k
        }
        if let destination = segue.destination as? AddBookVC{
            destination.library = library
        }
        if let destination = segue.destination as? BookSortVC{
            destination.library = library
            destination.who = "L"
        }
    }
    
}
