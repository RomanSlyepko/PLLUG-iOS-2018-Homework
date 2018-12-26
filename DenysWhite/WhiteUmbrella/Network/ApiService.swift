//
//  ApiService.swift
//  WhiteUmbrella
//
//  Created by Denys White on 11/19/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case unknown
    case notRightURL
}

enum ApiResult<T: Codable> {
    case success(T)
    case failure(Error)
}

final class ApiService {
    
    private init() {}
    static let shared = ApiService()
    
    func request<T: Codable>(request: URLRequest, type: T.Type, completion: @escaping (ApiResult<T>) -> ()) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error ?? ApiError.unknown))
            }
        }
        task.resume()
    }
}
