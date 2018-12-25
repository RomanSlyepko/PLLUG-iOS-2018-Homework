//
//  Network.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/7/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

// -------------------------------------
// MARK: - NetworkError
// -------------------------------------
enum NetworkError: Error {
    case decoderError
    case serverError(Error)
    case unknown
}

// -------------------------------------
// MARK: - NetworkResult
// -------------------------------------
enum NetworkResult<T: Codable> {
    case success(T)
    case failure(NetworkError)
}

// -------------------------------------
// MARK: - Network
// -------------------------------------
final class Network {
    
    private init() {}
    static let shared = Network()
    
    func requestData<T: Codable>(request: Router,
                                 as type: T.Type,
                                 completion: @escaping (NetworkResult<T>) -> ()) {
        
        Alamofire.request(request).validate(statusCode: 200..<300).responseData {
            switch $0.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(.decoderError))
                }
            case .failure(let error):
                completion(.failure(.serverError(error)))
            }
        }
    }
    
    func requestImage(url: String, completion: @escaping ((UIImage?) -> ())) {
        Alamofire.request(url).responseImage { response in
            completion(response.result.value)
        }
    }
}


