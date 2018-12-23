//
//  Network.swift
//  SongKick
//
//  Created by Roman on 12/9/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

enum NetworkErrors: String, Error {
    case NetworkError = "Error making api request"
    case ResponseError = "Error making api response"
    case DecodingError = "Error decoding api response"
}

enum NetworkResult {
    case success([Artist])
    case error(NetworkErrors)
}

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    private let request = "https://api.songkick.com/api/3.0/search/artists.json?apikey=io09K9l3ebJxmxe2&query="
    
    func request(for artist: String, completion: @escaping (NetworkResult) -> Void) {
        
        let url = URL(string: request+artist)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.error(.NetworkError))
            }
            guard
                let data = data,
                let response = response as? HTTPURLResponse
            else {
                completion(.error(.ResponseError))
                return
            }
            
            if response.statusCode != 200 {
                completion(.error(.ResponseError))
                return
            }
            
            guard
                let apiResponse = try? JSONDecoder().decode(Response.self, from: data),
                let artists = apiResponse.resultsPage.results?.artist
                else {
                    print("Error")

                    completion(.error(.DecodingError))
                    return
            }
            DispatchQueue.main.async {
                completion(.success(artists))
            }
        }.resume()
    }
}
