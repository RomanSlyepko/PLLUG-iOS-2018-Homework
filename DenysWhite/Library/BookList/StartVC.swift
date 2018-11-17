//
//  StartVC.swift
//  Library
//
//  Created by Denys White on 10/31/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    let library = Library()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        library.gen()
        
        for book in library.allBooks{
            for i in 0 ..< 100 {
                library.rentBook(book: book, borrower: "Reader\(i)")
                library.returnBook(book: book)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var runCount = Int8()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runCount += 1
            print(runCount)
            if runCount == 1 {
                timer.invalidate()
                self.performSegue(withIdentifier: "Start", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookListVC{
            destination.library = library
        }
    }

}
