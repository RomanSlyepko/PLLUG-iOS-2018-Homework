//
//  FavouritesArtists.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

class FavouritesArtists {
    
    static let shared = FavouritesArtists()
    
    var list = [Artist]()
    
    private init() {}
    
}
