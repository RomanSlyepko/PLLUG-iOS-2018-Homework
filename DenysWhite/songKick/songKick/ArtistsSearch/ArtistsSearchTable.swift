//
//  ArtistsSearchTable.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation
import UIKit

extension ArtistsSearchVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundArtists.isEmpty ? 0 : foundArtists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistsSearchTVCell") as! ArtistsSearchTVCell
        
        let currentArtist = foundArtists[indexPath.row]
        
        cell.artist = currentArtist
        
        if FavouritesArtists.shared.list.contains(currentArtist){
            cell.favouriteCheckerImage.image = #imageLiteral(resourceName: "starFilled")
        }else{
            cell.favouriteCheckerImage.image = #imageLiteral(resourceName: "starUnfilled")
        }
        
        pagination(indexPath: indexPath)
        
        return cell
        
    }
    
    func pagination(indexPath: IndexPath){
        if indexPath.row == foundArtists.count - 1 {
            PageManager.shared.nextPage {
                request(type: .pagination)
            }
        }
    }
    
}

extension ArtistsSearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentArtist = foundArtists[indexPath.row]
        
        if !FavouritesArtists.shared.list.contains(currentArtist){
            FavouritesArtists.shared.list.append(currentArtist)
        }else{
            FavouritesArtists.shared.list.delete(currentArtist)
        }
        
        ArtistsSearchTableView.reloadData()
    }
    
}
