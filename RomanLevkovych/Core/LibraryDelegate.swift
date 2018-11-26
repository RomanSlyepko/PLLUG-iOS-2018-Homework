//
//  LibraryDelegate.swift
//  RomanLevkovych
//
//  Created by Roman on 11/17/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

protocol LibraryDelegate: class {
    func bookDidTaken(book: Book)
    func bookDidGetBack(book: Book)
    func bookDidAdded(book: Book)
}

extension LibraryDelegate {
    func bookDidTaken(book: Book) {
        print(String(describing: book) + " were taken")
    }
    
    func bookDidGetBack(book: Book) {
            print("\(book) were gotten back to library")
    }
    
    func bookDidAdded(book: Book) {
        print("\(book) were added to library")
    }
}
