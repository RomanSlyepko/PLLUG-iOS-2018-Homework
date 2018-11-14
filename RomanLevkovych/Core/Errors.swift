//
//  Errors.swift
//  Levkovych
//
//  Created by Roman on 11/6/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

enum LibraryErrors: Error {
    case BookIsTaken
    case BookHaveReturned
    case BookIsInLibrary
}
