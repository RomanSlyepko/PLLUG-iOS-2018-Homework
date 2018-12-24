//
//  SearchArtistViewController.swift
//  SongKick
//
//  Created by Roman on 12/9/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit


class SearchArtistViewController: UIViewController {

    @IBOutlet weak var searchArtistSearchBar: UISearchBar!
    @IBOutlet weak var foundArtistsTableView: UITableView!
    
    fileprivate func reloadTableView() {
        self.foundArtistsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegates()
        registerNib()
    }
    
    fileprivate func configureDelegates() {
        self.searchArtistSearchBar.delegate = self
        
        self.foundArtistsTableView.delegate = self
        self.foundArtistsTableView.dataSource = self
    }
    
    fileprivate func registerNib() {
        let nib = UINib(nibName: ArtistTableViewCell.identifier, bundle: nil)
        self.foundArtistsTableView.register(nib, forCellReuseIdentifier: ArtistTableViewCell.identifier)
    }
    
    func save(artists: [Artist]) {
        DispatchQueue.main.async {
            DataStorager.shared.artists = artists
            self.reloadTableView()
        }
    }
    
    func search(for artist: String) {
        NetworkManager.shared.request(for: artist) {
            switch $0 {
            case .success(let data):
                self.save(artists: data)
            case .error(let error):
                Alert.showErrorAlert(on: self, message: error.rawValue)
            }
        }
    }
    
    fileprivate func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let artist = DataStorager.shared.artists[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Add to Favourite") { action, view, completion in
            if !DataStorager.shared.favouriteArtists.contains(artist) {
                DataStorager.shared.favouriteArtists.append(artist)
                completion(true)
            }
        }
        action.backgroundColor = .green
        print(DataStorager.shared.favouriteArtists)
        
        return action
    }
    
    
}

// MARK: - UITableViewDataSource
extension SearchArtistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataStorager.shared.artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.foundArtistsTableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier) as! ArtistTableViewCell
        cell.artistNameLabel.text = DataStorager.shared.artists[indexPath.row].name
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension SearchArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favourite = favouriteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [favourite])
    }
}

//MARK: - UISearchBarDelegate
extension SearchArtistViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchArtistSearchBar.resignFirstResponder()
        guard
            let artistName = self.searchArtistSearchBar.text,
            let artistSearch = validateArtist(artistName)
            else {
                Alert.showErrorAlert(on: self, message: "Incorrect artist name")
                return
        }
        self.search(for: artistSearch)
        
    }
}
