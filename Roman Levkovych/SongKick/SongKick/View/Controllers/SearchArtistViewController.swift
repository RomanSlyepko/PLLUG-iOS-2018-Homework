//
//  SearchArtistViewController.swift
//  SongKick
//
//  Created by Roman on 12/9/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit


class SearchArtistViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var searchArtistSearchBar: UISearchBar!
    @IBOutlet weak var foundArtistsTableView: UITableView!
    
    private var artistToPass: Artist?
    private var page: Int = 1
    private var maximumPages: Int = 1

    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegates()
        registerNib()
        
    }

    // MARK: - Config UI
    fileprivate func reloadTableView() {
        self.foundArtistsTableView.reloadData()
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

    // MARK: - Network Requests
    fileprivate func search(for artist: String) {
        NetworkManager.shared.getArtist(for: artist) {
            switch $0 {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let artists = data.results?.artist else { return }
                    self.maximumPages = data.totalEntries / data.perPage + 1
                    DataStorager.shared.artists = artists
                    self.reloadTableView()
                }
            case .error(let error):
                Alert.showErrorAlert(on: self, message: error.rawValue)
            }
        }
    }

    fileprivate func searchNext(for artist: String) {
        self.page += 1
        if self.page <= self.maximumPages {
            NetworkManager.shared.getArtistPage(for: artist, page: page) {
                switch $0 {
                case .success(let data):
                    DispatchQueue.main.async {
                        guard let artists = data.results?.artist else { return }
                        DataStorager.shared.artists += artists
                        self.reloadTableView()
                    }
                case .error(let error):
                    Alert.showErrorAlert(on: self, message: error.rawValue)
                }
            }
        }
    }

    // MARK: - Swipe Actions
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

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.showInfo.rawValue {
            guard let vc = segue.destination as? ArtistInfoViewController else { return }
            vc.artist = self.artistToPass
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.artistToPass = DataStorager.shared.artists[indexPath.row]
        
        performSegue(withIdentifier: Segues.showInfo.rawValue, sender: self)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == DataStorager.shared.artists.count - 1 {
            guard
                let artistName = self.searchArtistSearchBar.text,
                let artistToSearch = validateArtist(artistName)
                else { return }
            self.searchNext(for: artistToSearch)
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchArtistViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        guard
            let artistName = searchBar.text,
            let artistSearch = validateArtist(artistName)
            else {
                Alert.showErrorAlert(on: self, message: "Incorrect artist name")
                return
        }
        self.search(for: artistSearch)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
