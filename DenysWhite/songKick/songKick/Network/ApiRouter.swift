//
//  ApiRouter.swift
//  News
//
//  Created by Denys White on 11/19/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

enum ApiRouter {
    
    private static let apiKey = URLQueryItem(name: "apikey", value: "io09K9l3ebJxmxe2")
    private static let baseURL = "https://api.songkick.com"
    
    case artistsSearch(searchParameter: String?,page: String?)
    
    
    private var path: String {
        switch self {
        case .artistsSearch:
            return "/api/3.0/search/artists.json"
        }
    }
    
    private var queryParameters: [String: String] {
        switch self {
        case .artistsSearch(let searchParameter, let page):
            var parameters : [String: String] = [:]
            parameters["query"] = searchParameter
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
        }
    }
    
    private var requestUrl: URL?{
        guard var comp = URLComponents(string: ApiRouter.baseURL) else { return nil }
        comp.path = path
        comp.queryItems = (queryParameters.map{ URLQueryItem(name: $0.key, value: $0.value) }) + [ApiRouter.apiKey]
        return comp.url
    }
    
    func asRequest() throws -> URLRequest {
        guard let url = requestUrl else{ throw ApiError.notRightURL }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = method.rawValue
        return urlReq
    }
}
