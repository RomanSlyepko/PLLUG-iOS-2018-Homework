//
//  ArtistData.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/10/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation

final class ArtistData {
    
    static let shared = ArtistData()
    private var observers: [DataObserver] = []
    
    private var songKickResult: SongKickModel?
    var favouriteArtists: [ArtistModel] = []
    
    // - TODO: Labels to show errors
    func fetchData(name: String) {
        let requestManager = RequestManager()
        requestManager.getSongKickData(request: SongKickRouter.findArtist(called: name)) {
            switch $0 {
            case .success(let model):
                print(model)
                self.songKickResult = model
                self.notify()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addNewFavourite(artist: ArtistModel) {
        guard favouriteArtists.contains(where: { $0.id == artist.id }) else {
            favouriteArtists.append(artist)
            notify()
            return
        }
    }
    
    func getArtists() -> [ArtistModel]? {
        return songKickResult?.resultsPage.results.artist
    }
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
    
    func notify() {
        observers.forEach { observer in
            observer.notifyDataChanged()
        }
    }
}
