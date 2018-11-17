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


enum ResultType {
    case ultravioletSuccess(Ultraviolet)
    case currentWeatherSuccess(CurrentWeather)
    case futureWeatherSuccess(FutureWeather)
    case failure(Error)
}


enum UltravioletResult {
    
    case success(rates: Ultraviolet)
    case failure(Error)
}

enum CurrentWeatherResult {
    
    case success(rates: CurrentWeather)
    case failure(Error)
}

enum FutureWeatherResult {
    
    case success(rates: FutureWeather)
    case failure(Error)
}
// -------------------------------------
// MARK: - DemoNetwork
// -------------------------------------
final class DemoNetwork {
    
    private init() {}
    static let shared = DemoNetwork()
    
    func requestUVData(request: URLRequest, completion: @escaping (UltravioletResult) -> ()) {
        Alamofire.request(request).validate(statusCode: 200..<300).responseData { result in
            switch result.result {
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
    
    func requestCurrentWeather(request: URLRequest, completion: @escaping (CurrentWeatherResult) -> ()) {
        Alamofire.request(request).validate(statusCode: 200..<300).responseData { result in
            switch result.result {
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
    
    
    func requestFutureWeather(request: URLRequest, completion: @escaping (FutureWeatherResult) -> ()) {
        Alamofire.request(request).validate(statusCode: 200..<300).responseData { result in
            switch result.result {
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

