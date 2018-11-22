//
//  DemoNetwork+FutureWeather.swift
//  hw_Weather
//
//  Created by user on 11/22/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation
import Alamofire

enum FutureWeatherResult {
    case success(rates: FutureWeather)
    case failure(Error)
}

extension DemoNetwork {
    
    func requestFutureWeather(request: String, completion: @escaping (FutureWeatherResult) -> ()) {
        requestData(url: request) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(FutureWeather.self, from: data)
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
