//
//  DemoNetwork.swift
//  SongKick
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//


import Foundation
import Alamofire

// MARK: - DemoNetworkError
enum DemoNetworkError: Error {
    
    case wrongUrlFormat
    case serverError(Error)
    case unknown
}


// MARK: - DemoNetworkResult
enum DemoNetworkResult {
    
    case success(Data)
    case failure(DemoNetworkError)
}


// MARK: - DemoNetwork
final class DemoNetwork {
    
    private init() {}
    static let shared = DemoNetwork()
    
    func requestData(url: String, completion: @escaping (DemoNetworkResult) -> ()) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.wrongUrlFormat))
            return
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(request).validate(statusCode: 200..<300).responseData {
            switch $0.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.serverError(error)))
            }
        }
    }
}
