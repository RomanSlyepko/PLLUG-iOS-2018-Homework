//
//  DataManager.swift
//  hw_Weather
//
//  Created by user on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import Foundation

let apiKey = "815eb5fbd492c6f6ad5df20dab717b02"
let shortApiString = "http://api.openweathermap.org/data/2.5/"


class DataManager {

    func getUVIndex(withLat lat: String, andLong long: String, completion: @escaping (Ultraviolet) -> (), failure: ((_ error: Error) -> Void)?) {
        let apiString = "\(shortApiString)uvi?appid=\(apiKey)&lat=\(lat)&lon=\(long)"
        DemoNetwork.shared.requestUVData(request: apiString) { result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Error 1: \(error.localizedDescription)")
                failure!(error)
            }
        }
    }
    
    func getCurrentWeather(withLat lat: String, andLong lon: String, completion: @escaping (CurrentWeather) -> (), failure: ((_ error: Error) -> Void)?) {
        let apiString = "\(shortApiString)weather?lat=\(lat)&lon=\(lon)&APPID=\(apiKey)"
        DemoNetwork.shared.requestCurrentWeather(request: apiString) { result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                failure!(error)
            }
        }
    }
    
    func getFututeWeather(forCity city: String, completion: @escaping (FutureWeather) -> (), failure: ((_ error: Error) -> Void)?) {
        let apiString = "\(shortApiString)forecast?q=\(city)&APPID=\(apiKey)"
        DemoNetwork.shared.requestFutureWeather(request: apiString) { result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                failure!(error)
            }
        }
    }
}
