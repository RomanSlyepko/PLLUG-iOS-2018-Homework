//
//  Observable.swift
//  RomanLevkovych
//
//  Created by Roman on 11/13/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

protocol Observer {
    
    var id: Int {get}
    var book: Book {get}
    
    func update(action: Actions)
}

enum Actions: String {
    case taken = " were taken"
    case added = " added to library"
    case gotBack = " taken back to library"
}
