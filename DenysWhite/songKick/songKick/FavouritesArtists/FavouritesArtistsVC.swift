//
//  FavouritesArtistsVC.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class FavouritesArtistsVC: UIViewController {

    @IBOutlet weak var favouritesArtistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesArtistTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        load()
    }
    
    func load(){
        if FavouritesArtists.shared.list.isEmpty{
            favouritesArtistTableView.isHidden = true
        }else{
            favouritesArtistTableView.isHidden = false
            favouritesArtistTableView.reloadData()
        }
    }
    
}
