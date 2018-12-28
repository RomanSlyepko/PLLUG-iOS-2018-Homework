//
//  SearchResults.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

struct SearchResults: Codable{
    
    var status: String
    var error: ApiResultsError?
    var perPage: Int?
    var page: Int?
    var totalEntries: Int?
    var results: Results?
    
}
