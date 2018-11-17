//
//  BookHistoryVC.swift
//  Library
//
//  Created by Denys White on 10/30/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class BookHistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var library = Library()
    
    var k = Int()
    
    var book = Book()
    
    var bookHistory = [History]()
    var allFiltersArray = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let font = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
        
        allFiltersArray = sort(filterСoefficient: f(), sortedСoefficient: k)
        
    }
    
    func f()->Int{
        return segment!.selectedSegmentIndex
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
        let bookHistoryEvent = allFiltersArray[indexPath.row]
        
        cell.textLabel?.text = "\(bookHistoryEvent.type)\n"
        cell.detailTextLabel?.text = "Date: \(bookHistoryEvent.date)\nBy: \(bookHistoryEvent.borrower)"
        
        return cell
    }
    
    @IBAction func segmentTap(_ sender: Any) {
        UIView .performWithoutAnimation {
            table.isHidden = false
            allFiltersArray = sort(filterСoefficient: f(), sortedСoefficient: k)
            self.table.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        allFiltersArray = sort(filterСoefficient: f(), sortedСoefficient: k).filter({ history -> Bool in
            if searchText.isEmpty {return true}
            return history.borrower.lowercased().contains(searchText.lowercased()) ||
                history.date.lowercased().contains(searchText.lowercased())
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
    
    func sort(filterСoefficient: Int, sortedСoefficient: Int)->[History]{
        
        var resultArray = [History]()
        
        switch filterСoefficient{
        case 0:
            resultArray = bookHistory
        case 1:
            resultArray = bookHistory.filter({ history -> Bool in
                history.type == HistoryType.In
            })
        case 2:
            resultArray = bookHistory.filter({ history -> Bool in
                history.type == HistoryType.Out
            })
        default: break
        }
        
        switch sortedСoefficient {
        case 1:
            resultArray = bookHistory.sorted(by: {
                $0.borrower < $1.borrower
            })
        case 2:
            resultArray = bookHistory.sorted(by: {
                $0.borrower > $1.borrower
            })
        case 3:
            resultArray = bookHistory.sorted(by: {
                getDateFromString(stringDate: $0.date) > getDateFromString(stringDate: $1.date)
            })
        case 4:
            resultArray = bookHistory.sorted(by: {
                getDateFromString(stringDate: $0.date) < getDateFromString(stringDate: $1.date)
            })
        default: break
        }
        
        return resultArray
        
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? BookInfoVC{
                destination.book = book
                destination.library = library
            }
            if let destination = segue.destination as? BookSortVC{
                destination.library = library
                destination.bookHistory = bookHistory
                destination.book = book
            }
        }
    
}
