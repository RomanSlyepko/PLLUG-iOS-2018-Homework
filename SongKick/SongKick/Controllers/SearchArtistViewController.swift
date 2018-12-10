//
//  SearchArtistViewController.swift
//  SongKick
//
//  Created by Roman on 12/9/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit


class SearchArtistViewController: UIViewController {

    fileprivate var artists = [Artist]()
    fileprivate var favouriteArtists = [Artist]()
    @IBOutlet weak var searchArtistSearchBar: UISearchBar!
    @IBOutlet weak var foundArtistsTableView: UITableView!
    
    fileprivate func configureDelegates() {
        self.searchArtistSearchBar.delegate = self
        self.foundArtistsTableView.delegate = self
        self.foundArtistsTableView.dataSource = self
    }
    
    fileprivate func registerNib() {
        let nib = UINib(nibName: ArtistTableViewCell.identifier, bundle: nil)
        self.foundArtistsTableView.register(nib, forCellReuseIdentifier: ArtistTableViewCell.identifier)
    }
    
    #warning("Force update the tableview after uploading data")
    fileprivate func reloadTableView() {
        
        self.foundArtistsTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegates()
        registerNib()
    }
    
    func save(artists: [Artist]) {
        DispatchQueue.main.async {
            self.artists = artists
        }
        self.reloadTableView()
    }
    
    func search(for artist: String) {
        NetworkManager.shared.request(for: artist) {
            switch $0 {
            case .success(let data):
                print("data: \(data)")
                self.save(artists: data)
            case .error(let error):
                print(error)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension SearchArtistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.foundArtistsTableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier) as! ArtistTableViewCell
        cell.artistNameLabel.text = self.artists[indexPath.row].displayName
        return cell
    }
    
    
}

extension SearchArtistViewController: UITableViewDelegate {
    
}

extension SearchArtistViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let artistName = self.searchArtistSearchBar.text else { return }
        print(artistName)
        
        self.search(for: artistName)
        
    }
}
