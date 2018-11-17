//
//  DemoNetwork.swift
//  hw_Weather
//
//  Created by Alex Chaku on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation
import Alamofire

// -------------------------------------
// MARK: - DemoNetworkResult
// -------------------------------------
enum DemoNetworkResult {
    
    case success(Data)
    case failure(Error)
}

// -------------------------------------
// MARK: - DemoNetwork
// -------------------------------------
final class DemoNetwork {
    
    private init() {}
    static let shared = DemoNetwork()
    
    func requestData(request: URLRequest, completion: @escaping (DemoNetworkResult) -> ()) {
        
        Alamofire.request(request).validate(statusCode: 200..<300).responseData {
            switch $0.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
