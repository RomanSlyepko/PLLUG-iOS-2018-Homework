//
//  RequestManager.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/10/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation
import UIKit

// -------------------------------------
// MARK: - RequestManager
// -------------------------------------
class RequestManager {
    func getSongKickData(request: Router,
                         completion: @escaping (NetworkResult<SongKickModel>) -> ()) {
        Network.shared.requestData(request: request,
                                   as: SongKickModel.self,
                                   completion: completion)
    }
    
    func getArtistImage(id: Int,
                        completion: @escaping ((UIImage?) -> ())) {
        let url = "https://images.sk-static.com/images/media/profile_images/artists/\(id)/huge_avatar"
        Network.shared.requestImage(url: url,
                                    completion: completion)
    }
}
