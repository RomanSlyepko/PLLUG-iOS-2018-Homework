//
//  FirstViewController.swift
//  SongKick
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let dataManager = DataManager()
    var searchingArtist: SingerSearch?
    var allArtist = [Artist]()
    
    private var page = 1
    private var total = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? SingerDetailViewController
        guard let indexPathRow = tableView.indexPathForSelectedRow?.row else { return }
        detailVC?.singer = allArtist[indexPathRow]
        detailVC?.isFavorite = false
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Search error", message: "Unable to find artist", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func getData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        dataManager.searchSinger(withName: searchBar.text!, page: page, completion: { (result) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.allArtist += result.resultsPage.results.artist
                self.searchingArtist = result
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.showAlert()
            }
        }
    }
    
    func resetArtist() {
        page = 1
        total = 50
        allArtist = [Artist]()
        searchingArtist = nil
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allArtist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchSinger") as! SearchingSingerTableViewCell
        cell.singerNameLabel.text = allArtist[indexPath.row].displayName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = allArtist[indexPath.row]
        performSegue(withIdentifier: "SingerDetail", sender: artist)
        searchBar.resignFirstResponder()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let totalEntries = searchingArtist?.resultsPage.totalEntries else { return }
        if indexPath.row == (total - 5), totalEntries > total{
            page += 1
            total += 50
            getData()
        }
    }
}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil, searchBar.text != "" {
            resetArtist()
            getData()
        } else {
            resetArtist()
            self.tableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetArtist()
        self.tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
             resetArtist()
            self.tableView.reloadData()
        }
    }
}
