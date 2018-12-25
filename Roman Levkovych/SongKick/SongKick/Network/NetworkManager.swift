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
    
    
    func performRequest(route: APIRouter, completion: @escaping (NetworkResult) -> Void) {
        Network.shared.request(route: route, completion: completion)
    }
    
    func getArtist(for artist:String, completion: @escaping (NetworkResult) -> Void) {
        self.performRequest(route: .searchArtist(artist), completion: completion)
    }
    
    func getCalendar(for id: Int, completion: @escaping (NetworkResult) -> Void) {
        self.performRequest(route: .searchArtistCalendar(id), completion: completion)
    }
}
