//
//  Router.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/7/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation
import Alamofire

protocol Router: URLRequestConvertible {
    
    var baseURLString: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    
    func asURLRequest() throws -> URLRequest
    
}

// -------------------------------------
// MARK: -  SongKickRouter
// -------------------------------------
enum SongKickRouter: Router {
    case findArtist(called: String, perPage: Int, page: Int)
    case getEvents(for: String, perPage: Int, page: Int)
    
    var baseURLString: String { return "https://api.songkick.com/api/3.0/" }
    var APIKey: String { return "io09K9l3ebJxmxe2" }
    
    var method: HTTPMethod {
        switch self {
        case .findArtist, .getEvents:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .findArtist:
            return "search/artists.json"
        case .getEvents:
            return "events.json"
        }
        
    }
    
    var parameters: [String:Any] {
        switch self {
        case .findArtist(let name, let perPage, let page):
            return [KeyConstants.query:name,
                    KeyConstants.APIKey:self.APIKey,
                    KeyConstants.perPage:perPage,
                    KeyConstants.page:page]
        case .getEvents(let name, let perPage, let page):
            return [KeyConstants.artistName:name,
                    KeyConstants.APIKey:self.APIKey,
                    KeyConstants.perPage:perPage,
                    KeyConstants.page:page]
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
    static let query: String = "query"
    static let artistName: String = "artist_name"
    static let APIKey: String = "apikey"
    static let page: String = "page"
    static let perPage: String = "per_page"
}
