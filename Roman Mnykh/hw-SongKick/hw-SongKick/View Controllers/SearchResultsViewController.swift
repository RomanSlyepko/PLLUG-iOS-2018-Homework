//
//  SearchViewController.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/7/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit
//import SkeletonView

class SearchResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var searchResult: SongKickModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        ArtistData.shared.addObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: SearchCell.identifier, bundle: nil), forCellReuseIdentifier: SearchCell.identifier)
        tableView.isHidden = true
    }
    
    private func configureNavigationBar() {
        navigationController!.navigationBar.barStyle = .black
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

extension SearchResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            ArtistData.shared.fetchData(name: text)
            tableView.isHidden = false
        }
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArtistData.shared.getArtists()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier) as! SearchCell
        if let artistModel = ArtistData.shared.getArtists()?[indexPath.row] {
            cell.setDataFromModel(artistModel)
        }
        
        return cell
    }
    
}

extension SearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favouriteAction = UITableViewRowAction(style: .default, title: "Favourite", handler: {action,indexPath in
            if let artist = ArtistData.shared.getArtists()?[indexPath.row] {
                ArtistData.shared.addNewFavourite(artist: artist)
            }
        })

        favouriteAction.backgroundColor = .black
        
        return [favouriteAction]
    }
}

extension SearchResultsViewController: DataObserver {
    func notifyDataChanged() {
        tableView.reloadData()
    }
}
