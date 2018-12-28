//
//  ArrayManager.swift
//  songKick
//
//  Created by Denys White on 12/28/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

class ArrayManager {
    static let shared = ArrayManager()
    private init() {}

    func array<T>(results: Results, type: T.Type) -> T? {
        switch results {
        case .artist(let artistsArray):
            return artistsArray as? T
        case .event(let eventsArray):
            return eventsArray as? T
        case .unsupported:
            return nil
        }
    }

    func arrayAction<T>(type: T.Type, result: ResultsPage, action: (_ array: T)->(), elseAction: (()->())? = nil){
        if let result = result.resultsPage.results, let array = ArrayManager.shared.array(results: result, type: type){
            action(array)
        }else{
            elseAction?()
        }
    }
}
