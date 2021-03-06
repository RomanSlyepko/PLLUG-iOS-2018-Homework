//
//  ViewController.swift
//  SongKick
//
//  Created by Roman on 12/6/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit

class FavoutireArtistViewController: UIViewController {

    //MARK: - ui elements
    @IBOutlet weak var favouriteArtistsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerDelegates()
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.favouriteArtistsTableView.reloadData()
    }
    
    fileprivate func registerNibs() {
        let nib = UINib(nibName: ArtistTableViewCell.identifier, bundle: nil)
        self.favouriteArtistsTableView.register(nib, forCellReuseIdentifier: ArtistTableViewCell.identifier)
    }
    
    fileprivate func registerDelegates() {
        self.favouriteArtistsTableView.dataSource = self
        self.favouriteArtistsTableView.delegate = self
    }
    
    fileprivate func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            DataStorager.shared.favouriteArtists.remove(at: indexPath.row)
            self.favouriteArtistsTableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        return action
    }
}

// MARK: - UITableViewDataSource
extension FavoutireArtistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataStorager.shared.favouriteArtists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier) as! ArtistTableViewCell
        cell.artistNameLabel.text = DataStorager.shared.favouriteArtists[indexPath.row].name
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoutireArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}


