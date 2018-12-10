//
//  FirstViewController.swift
//  SongKick
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let dataManager = DataManager()
    var searchingArtist: SingerSearch?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? SingerDetailViewController
        if let artist = sender as? Artist {
            detailVC?.singer = artist
            detailVC?.isFavorite = false
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Search error", message: "Unable to find artist", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func getData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        dataManager.searchSinger(withName: searchBar.text!, completion: { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.searchingArtist = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.showAlert()
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchingArtist?.resultsPage.results.artist.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchSinger") as! SearchingSingerTableViewCell
        cell.singerNameLabel.text = searchingArtist?.resultsPage.results.artist[indexPath.row].displayName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = searchingArtist?.resultsPage.results.artist[indexPath.row]
        performSegue(withIdentifier: "SingerDetail", sender: artist)
        searchBar.resignFirstResponder()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil, searchBar.text != "" {
            getData()
        } else {
            searchingArtist = nil
            self.tableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchingArtist = nil
        self.tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            searchingArtist = nil
            self.tableView.reloadData()
        }
    }
}

