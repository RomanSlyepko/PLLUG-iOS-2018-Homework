//
//  DataStorager.swift
//  SongKick
//
//  Created by Roman on 12/10/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

class DataStorager {
    private init() {}
    
    static let shared = DataStorager()
    
    var artists = [Artist]()
    var favouriteArtists = [Artist]()
    var artistEvents = [Event]()
}
