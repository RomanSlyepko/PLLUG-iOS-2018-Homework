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
    case success(Results)
    case error(NetworkErrors)
}

class Network {
    private init() {}
    static let shared = Network()
    
    func request(route: APIRouter, completion: @escaping (NetworkResult) -> Void) {
        guard let url = try? route.asURL() else { return }
        self.sendRequest(with: url, completion: completion)
    }
    
    private func sendRequest(with url: URL, completion: @escaping (NetworkResult) -> Void) {
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
                let results = apiResponse.resultsPage.results
                else {
                    print("Error")
                    completion(.error(.DecodingError))
                    return
            }
            DispatchQueue.main.async {
                completion(.success(results))
            }
            }.resume()
    }
    
}
