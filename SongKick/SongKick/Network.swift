//
//  Network.swift
//  SongKick
//
//  Created by Roman on 12/9/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

enum NetworkErrors: String, Error {
    case ResponseError = "Error making api response"
    case DecodingError = "Error decoding api response"
}

class Network {
    private init() {}
    static let shared = Network()
    private let request = "https://api.songkick.com/api/3.0/search/artists.json?apikey=io09K9l3ebJxmxe2&query="
    
    func request(for artist: String, onSuccess: @escaping ([Artist]) -> Void, onError: @escaping (NetworkErrors) -> Void) {
        let url = URL(string: request+artist)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data
            else {
                #warning("TODO: set alert in case of error")
                onError(.ResponseError)
                return
            }
            
            guard
                let apiResponse = try? JSONDecoder().decode(Response.self, from: data),
                let artists = apiResponse.resultsPage.results?.artist
                else {
                    print("Error")

                    onError(.DecodingError)
                    return
            }
            DispatchQueue.main.async {
                onSuccess(artists)
            }
        }.resume()
    }
}
