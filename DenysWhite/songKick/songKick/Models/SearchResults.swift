//
//  SearchResults.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

struct SearchResults: Codable{
    
    var status = String()
    var error = ApiResultsError()
    var perPage = Int()
    var page = Int()
    var totalEntries = Int()
    var results = Results()
   
    
    enum CodingKeys: String, CodingKey {
        case status
        case error
        case perPage
        case page
        case totalEntries
        case results
    }
    
    init(){}
    
    init(from decoder: Decoder) throws{
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try container.decode(String.self, forKey: .status)
        
        if status == "ok"{
            
            perPage = try container.decode(Int.self, forKey: .perPage)
            page = try container.decode(Int.self, forKey: .page)
            totalEntries = try container.decode(Int.self, forKey: .totalEntries)
            results = try container.decode(Results.self, forKey: .results)
            
        }else{
            
            error = try container.decode(ApiResultsError.self, forKey: .error)
        }
        
    }
    
}
