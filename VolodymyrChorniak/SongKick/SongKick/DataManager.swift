//
//  DataManager.swift
//  SongKick
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

class DataManager {
    
    private let baseAPI = "https://api.songkick.com/api/3.0/search/artists.json?"
    private let apiKey = "io09K9l3ebJxmxe2&query"

    func searchSinger(withName name: String, completion: @escaping (SingerSearch) -> (), failure: ((_ error: Error) -> Void)?) {
        let apiString = "\(baseAPI)apikey=\(apiKey)&query=\(name)"
        let searchString = apiString.replacingOccurrences(of: " ", with: "+")
        DemoNetwork.shared.requestSingerData(request: searchString) { result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Error 1: \(error.localizedDescription)")
                failure!(error)
            }
        }
    }
}
