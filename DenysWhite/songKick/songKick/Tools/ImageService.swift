//
//  ImageService.swift
//  songKick
//
//  Created by Denys White on 12/25/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation
import UIKit

enum ImageServiceErrors: Error{
    case notRightURL
    case unpossibleToGetDataFromURL
    case unpossibleToDownloadImage
}

enum DownloadResult {
    case success(UIImage)
    case failure(ImageServiceErrors)
}

class ImageService {
    
    static let shared = ImageService()
    
    private init() {}
    
    func imageURLRouter(id: String) throws -> URL {
        let baseURL = "https://images.sk-static.com/images/media/profile_images/artists/\(id)/huge_avatar"
        guard let url = URL(string: baseURL) else { throw ImageServiceErrors.notRightURL }
        return url
    }
    
    func downloadImage(artistID: String,_ completion: @escaping (_ result: DownloadResult)->()){
        do{
            let imageURL = try imageURLRouter(id: artistID)
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = try? Data(contentsOf: imageURL){
                    if let image = UIImage(data: data){
                        completion(.success(image))
                    }else{
                        completion(.failure(.unpossibleToDownloadImage))
                    }
                }else{
                    completion(.failure(.unpossibleToGetDataFromURL))
                }
            }
        }catch{
            print("no data")
        }
    }
}
