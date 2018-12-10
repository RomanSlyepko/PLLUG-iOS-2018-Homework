//
//  FavoritsSingersList.swift
//  SongKick
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

class FavoriteArtist {
    static let sharedArtist = FavoriteArtist()
    private(set) var saved: [Artist] = []
    
    
    func saveArtist(artist: Artist) -> Bool {
        if !inArray(artist: artist) {
            saved.append(artist)
            return true
        }
        return false
    }
    
    private func inArray(artist: Artist) -> Bool {
        for singer in saved {
            if singer.id == artist.id {
                return true
            }
        }
        return false
    }
    
    func deleteArtist(index: Int) {
            saved.remove(at: index)
    }
    
}
