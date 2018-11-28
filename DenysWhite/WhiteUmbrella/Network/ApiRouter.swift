//
//  ApiRouter.swift
//  WhiteUmbrella
//
//  Created by Denys White on 11/19/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

enum NewsApiRouter {
    
    private static let apiKey = URLQueryItem(name: "appid", value: "b6907d289e10d714a6e88b30761fae22")
    
    case weather
    case forecast
    case uvi
    
    
    var path: String {
        switch self {
        case .weather:
            return "/data/2.5/weather"
        case .forecast:
            return "/data/2.5/forecast"
        case .uvi:
            return "/data/2.5/uvi"
        }
    }
    
    var queryParameters: [String: String] {
        switch self {
        case .weather:
            return ["q":"London"]
        case.forecast:
            return ["q":"London"]
        case .uvi:
            return ["lat":"37.75",
                    "lon":"-122.37"]
        }
    }
    
    var method: String {
        switch self {
        case .weather:
            return "GET"
        case .forecast:
            return "GET"
        case .uvi:
            return "GET"
        }
    }
    
    var requestUrl: URL?{
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "samples.openweathermap.org"
        comp.path = path
        comp.queryItems = [NewsApiRouter.apiKey]
        
        for par in queryParameters.sorted(by: < ){
            if !par.value.isEmpty {
                comp.queryItems?.append(URLQueryItem(name: par.key, value: par.value))
            }
        }
        
        return comp.url
    }
    
    func asRequest() throws -> URLRequest {
        guard let url = requestUrl else{ throw ApiError.notRightURL }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = method
        return urlReq
    }
}
