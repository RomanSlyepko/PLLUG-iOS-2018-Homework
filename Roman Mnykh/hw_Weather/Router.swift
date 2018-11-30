//
//  Router.swift
//  hw_Weather
//
//  Created by Roman Mnykh on 11/29/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation
import Alamofire

// -------------------------------------
// MARK: - Router
// -------------------------------------
protocol Router: URLRequestConvertible {
    
    var baseURLString: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    
    func asURLRequest() throws -> URLRequest
    
}

// -------------------------------------
// MARK: - WeatherRouter
// -------------------------------------
enum WeatherRouter<T: Codable>: Router {
    case weatherAtLocation(lantitude: Double, longtitude: Double)
    case weatherInCity(_ city: String)
    
    var baseURLString: String { return "http://api.openweathermap.org/data/2.5/" }
    var APIKey: String { return "2244e9c9efaca89dab3f87ebf7652658" }
    
    var method: HTTPMethod {
        switch self {
        case .weatherAtLocation, .weatherInCity:
            return .get
        }
    }
    
    var path: String {
        return (WeatherData.self == T.self) ? KeyConstants.weather : KeyConstants.forecast
    }
    
    var parameters: [String:Any] {
        switch self {
        case .weatherInCity(let city):
            return [KeyConstants.city: city,
                    KeyConstants.APIKey: APIKey]
        case .weatherAtLocation(let latitude, let longtitude):
            return [KeyConstants.latitude: latitude,
                    KeyConstants.longtitude: longtitude,
                    KeyConstants.APIKey: APIKey]
        }
    }
        
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
}

enum KeyConstants {
    static let city: String = "q"
    static let latitude: String = "lat"
    static let longtitude: String = "lon"
    static let APIKey: String = "APPID"
    static let weather: String = "weather"
    static let forecast: String = "forecast"
}
