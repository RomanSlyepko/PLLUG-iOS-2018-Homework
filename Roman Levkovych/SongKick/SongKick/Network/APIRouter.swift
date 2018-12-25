//
//  APIRouter.swift
//  SongKick
//
//  Created by Roman on 12/25/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

protocol URLRequest {
    var baseURLString: String { get }
    func asURL() throws -> URL
}

enum APIRouter: URLRequest {
    case searchArtist(String)
    case searchArtistCalendar(Int)
    
    var baseURLString: String { return  "https://api.songkick.com/api/3.0/" }
    private var apiKey: String { return "io09K9l3ebJxmxe2" }
    
    private var path: String {
        switch self {
        case .searchArtist(let artist):
            return "search/artists.json?apikey=\(apiKey)&query=\(artist)"
        case .searchArtistCalendar(let id):
            return "artists/\(id)/calendar.json?apikey=\(apiKey)"
        }
    }
    
    func asURL() throws -> URL {
        guard let url = URL(string: baseURLString+path) else { throw NetworkErrors.NetworkError }
        return url
    }
}
