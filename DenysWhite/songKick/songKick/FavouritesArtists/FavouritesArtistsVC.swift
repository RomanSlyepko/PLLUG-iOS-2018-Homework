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
    private var selectedArtist: Artist!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArtistsDetailsVC {
            destination.currentArtist = selectedArtist
        }
    }
    
}

extension FavouritesArtistsVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavouritesArtists.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesArtistsCell")!
        
        cell.textLabel?.text = FavouritesArtists.shared.list[indexPath.row].displayName
        
        return cell
    }
    
}

extension FavouritesArtistsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let currentArtist = FavouritesArtists.shared.list[indexPath.row]
            FavouritesArtists.shared.list.delete(currentArtist)
            load()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArtist = FavouritesArtists.shared.list[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
}
