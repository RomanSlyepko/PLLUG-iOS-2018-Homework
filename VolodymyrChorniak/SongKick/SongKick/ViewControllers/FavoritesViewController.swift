//
//  SecondViewController.swift
//  SongKick
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View reload.")
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? SingerDetailViewController
        if let artist = sender as? Artist {
            detailVC?.singer = artist
            detailVC?.isFavorite = true
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteArtist.sharedArtist.saved.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteSigner") as! FavoriteSignerTableViewCell
        cell.singerNameLabel.text = FavoriteArtist.sharedArtist.saved[indexPath.row].displayName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = FavoriteArtist.sharedArtist.saved[indexPath.row]
        performSegue(withIdentifier: "FavoriteDetail", sender: artist)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            FavoriteArtist.sharedArtist.deleteArtist(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
