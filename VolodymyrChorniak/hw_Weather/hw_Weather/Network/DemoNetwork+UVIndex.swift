//
//  DemoNetwork+UVIndex.swift
//  hw_Weather
//
//  Created by user on 11/22/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation
import Alamofire

enum UltravioletResult {
    
    case success(rates: Ultraviolet)
    case failure(Error)
}

extension DemoNetwork {
    
    func requestUVData(request: String, completion: @escaping (UltravioletResult) -> ()) {
        requestData(url: request) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(Ultraviolet.self, from: data)
                    completion(.success(rates: result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
