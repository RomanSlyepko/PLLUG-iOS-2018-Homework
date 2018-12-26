//
//  ArtistData.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/10/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation
import UIKit

final class ArtistData {
    
    private init() {}
    
    static let shared = ArtistData()
    private var observers: [DataObserver] = []
    var favouriteArtists: [ArtistModel] = []
    
    func addNewFavourite(artist: ArtistModel) {
        guard favouriteArtists.contains(where: { $0.id == artist.id }) else {
            favouriteArtists.append(artist)
            notify(.favouriteDidAdd)
            return
        }
    }
    
    func removeNewFavourite(artist: ArtistModel) {
        if let index = favouriteArtists.firstIndex(where: { $0.id == artist.id } ) {
            favouriteArtists.remove(at: index)
            notify(.favouriteDidAdd)
        }
    }
}

enum ButtonOptions: String {
    case favourite = "Favourite"
    case remove = "Remove"
}


extension ArtistData: ObservableData {
    
    func addObserver(_ observer: DataObserver) {
        if observers.contains(where: { $0 === observer } ) == false {
            observers.append(observer)
        }
    }
    
    func removeObserver(_ observer: DataObserver) {
        if let index = observers.firstIndex(where: { $0 === observer } ) {
            observers.remove(at: index)
        }
    }
    
    func notify(_ action: Action) {
        observers.forEach { observer in
            observer.notifyDataChanged(action)
        }
    }
}
