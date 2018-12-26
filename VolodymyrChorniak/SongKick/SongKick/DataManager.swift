//
//  DataManager.swift
//  SongKick
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

class DataManager {

    func searchSinger(withName name: String, page: Int, completion: @escaping (SingerSearch) -> (), failure: @escaping ((_ error: Error) -> Void)) {
        let apiString = "\(Constants.baseAPI)\(Constants.artistSearch)apikey=\(Constants.apiKey)&query=\(name)&page=\(page)"
        let searchString = apiString.replacingOccurrences(of: " ", with: "+")
        DemoNetwork.shared.requestSingerData(request: searchString) { result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Error 1: \(error.localizedDescription)")
                failure(error)
            }
        }
    }
    
    func showEventsForArtist(withMbid mbid: String, page: Int, completion: @escaping(Events) -> (), failure: @escaping ((_ error: Error) -> Void)) {
        let apiString = Constants.baseAPI + Constants.eventForArtistAPI + mbid + "/calendar.json?" + "apikey=\(Constants.apiKey)" + "&page=\(page)"
        DemoNetwork.shared.requestEventsData(request: apiString) { result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Error load events: \(error.localizedDescription)")
                failure(error)
            }
        }
    }
}
