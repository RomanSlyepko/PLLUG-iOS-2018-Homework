//
//  PageManager.swift
//  songKick
//
//  Created by Denys White on 12/8/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

class PageManager{
    
    static let shared = PageManager()
    
    var page : Int = 1
    var totalResults = Int()
    
    private let resultsPerPage = 50
    private var maxPages : Int{
        return Int(ceil(Double(totalResults)/Double(resultsPerPage)))
    }
    
    func nextPage(action: ()->()){
        if page < maxPages{
            page += 1
            action()
        }
    }
    
    func resetPageCounting(){
        page = 1
    }
    
}
