//
//  FavouritesArtistsTable.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation
import UIKit

extension FavouritesArtistsVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavouritesArtists.shared.list.isEmpty ? 0 : FavouritesArtists.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesArtistsCell")!
        
        cell.textLabel?.text = FavouritesArtists.shared.list[indexPath.row].displayName
        
        return cell
    }
    
}

extension FavouritesArtistsVC: UITabBarDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let currentArtist = FavouritesArtists.shared.list[indexPath.row]
            FavouritesArtists.shared.list.delete(currentArtist)
            favouritesArtistTableView.reloadData()
        }
    }
    
}
