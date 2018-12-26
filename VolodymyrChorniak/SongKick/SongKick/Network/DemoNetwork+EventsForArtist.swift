//
//  DemoNetwork+EventsForArtist.swift
//  SongKick
//
//  Created by user on 12/24/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation
import Alamofire

enum EventsResult {
    
    case success(rates: Events)
    case failure(Error)
}

extension DemoNetwork {
    func requestEventsData(request: String, completion: @escaping (EventsResult) -> ()) {
        requestData(url: request) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(Events.self, from: data)
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
