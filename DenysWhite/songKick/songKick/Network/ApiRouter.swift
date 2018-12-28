//
//  ApiRouter.swift
//  News
//
//  Created by Denys White on 11/19/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

enum ApiRouter {
    
    case artistsSearch(searchParameter: String?,page: String?)
    case eventsShow(href: String,page: String?)
}

extension ApiRouter {
    
    private static let apiKey = URLQueryItem(name: "apikey", value: "io09K9l3ebJxmxe2")
    
    private var baseURL: String {
        switch self {
        case .artistsSearch:
            return "https://api.songkick.com/api/3.0/search/artists.json"
        case .eventsShow(let href, _):
            return href
        }
    }
    
    private var queryParameters: [String: String] {
        switch self {
        case .artistsSearch(let searchParameter, let page):
            var parameters : [String: String] = [:]
            parameters["query"] = searchParameter
            parameters["page"] = page
            return parameters
        case .eventsShow( _, let page):
            var parameters : [String: String] = [:]
            parameters["page"] = page
            return parameters
        }
    }
    
    private enum HttpMethods: String{
        case get = "GET"
    }
    
    private var method: HttpMethods {
        switch self {
        case .artistsSearch:
            return .get
        case .eventsShow:
            return .get
        }
    }
    
    private var requestUrl: URL?{
        guard var components = URLComponents(string: baseURL) else { return nil }
        components.queryItems = (queryParameters.map{ URLQueryItem(name: $0.key, value: $0.value) }) + [ApiRouter.apiKey]
        return components.url
    }
    
    func asRequest() throws -> URLRequest {
        guard let url = requestUrl else{ throw ApiError.notRightURL }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = method.rawValue
        return urlReq
    }
}
