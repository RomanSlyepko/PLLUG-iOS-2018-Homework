//
//  BookInfoTVC.swift
//  Library
//
//  Created by Denys White on 10/30/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class BookInfoTVC: UITableViewController {

    var book = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let identifier = cell.reuseIdentifier {
            switch identifier {
            case "Cell1": cell.textLabel?.text = book.bookName
            case "Cell2": cell.textLabel?.text = book.authorName
            case "Cell3": cell.textLabel?.text = book.dateOfPublishing
            case "Cell4": cell.textLabel?.text = book.type.rawValue
            case "Cell5": if book.isRented {cell.textLabel?.text = "out"}else{cell.textLabel?.text = "in"}
            case "Cell6": cell.textLabel?.text = book.UUID
            default: break
            }
        }
    }
    
}
