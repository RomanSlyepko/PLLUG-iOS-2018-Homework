//
//  DemoNetwork+SearchSinger.swift
//  SongKick
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//


import Foundation
import Alamofire

enum SingerSearchResult {
    
    case success(rates: SingerSearch)
    case failure(Error)
}

extension DemoNetwork {
    func requestSingerData(request: String, completion: @escaping (SingerSearchResult) -> ()) {
        requestData(url: request) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(SingerSearch.self, from: data)
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
