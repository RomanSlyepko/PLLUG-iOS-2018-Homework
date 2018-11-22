//
//  DemoNetwork+CurrentWeather.swift
//  hw_Weather
//
//  Created by user on 11/22/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation
import Alamofire

enum CurrentWeatherResult {
    
    case success(rates: CurrentWeather)
    case failure(Error)
}

extension DemoNetwork {
    
    func requestCurrentWeather(request: String, completion: @escaping (CurrentWeatherResult) -> ()) {
        requestData(url: request) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(CurrentWeather.self, from: data)
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
