//
//  NetworkManager.swift
//  SongKick
//
//  Created by Roman on 12/25/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    
    private func performRequest(route: APIRouter, completion: @escaping (NetworkResult) -> Void) {
        Network.shared.request(route: route, completion: completion)
    }
    
    func getArtist(for artist:String, completion: @escaping (NetworkResult) -> Void) {
        self.performRequest(route: .searchArtist(artist, 1), completion: completion)
    }

    func getArtistPage(for artist: String, page: Int, completion: @escaping (NetworkResult) -> Void) {
        self.performRequest(route: .searchArtist(artist, page), completion: completion)
    }
    
    func getCalendar(for id: Int, completion: @escaping (NetworkResult) -> Void) {
        self.performRequest(route: .searchArtistCalendar(id, 1), completion: completion)
    }

    func getCalendarPage(for id: Int, page: Int, completion: @escaping (NetworkResult) -> Void) {
        self.performRequest(route: .searchArtistCalendar(id, page), completion: completion)
    }
}
