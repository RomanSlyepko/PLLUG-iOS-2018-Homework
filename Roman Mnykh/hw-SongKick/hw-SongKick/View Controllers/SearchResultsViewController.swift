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
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var searchString: String = ""
    var artists: [ArtistModel] = []
    
    var isFetchInProgress: Bool = false
    var currentPage: Int = 1
    var currentCount: Int = 0
    var totalCount: Int = 0
    let perPage: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? SearchCell,
            let indexPath = tableView.indexPath(for: cell),
            let destination = segue.destination as? EventsViewController {
            
            destination.artistModel = artists[indexPath.row]
        }
    }
    
    func fetchData() {
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        
        RequestManager.shared.getSongKickData(request: SongKickRouter.findArtist(called: searchString, perPage: perPage, page: currentPage)) {
            switch $0 {
            case .success(let model):
                self.artists.append(contentsOf: model.resultsPage.results.artist ?? [])
                self.totalCount = model.resultsPage.totalEntries
                
                // TODO: - Reload only cells that just got fetched
                self.tableView.reloadData()
            case .failure(_):
                break
            }
            
            if self.totalCount > self.currentCount + self.perPage {
                self.currentCount += self.perPage
            } else {
                self.currentCount = self.totalCount
            }
            self.isFetchInProgress = false
            self.currentPage += 1
            
            if self.artists.isEmpty {
                self.createLabelWithText("No results")
            } else {
                self.informationView.isHidden = true
            }
            
            if let viewWithTag = self.informationView.viewWithTag(75) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
    
    func resetSearchParameters() {
        tableView.reloadData()
        currentPage = 1
        currentCount = 0
        totalCount = 0
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: SearchCell.identifier, bundle: nil), forCellReuseIdentifier: SearchCell.identifier)
    }
    
    func createLabelWithText(_ text: String)
    {
        let height = informationView.bounds.size.height
        let width = informationView.bounds.size.width
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.text = text
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 40)
        label.tag = 50
        informationView.addSubview(label)
        self.informationView.isHidden = false
    }
    
    private func configureLoadingView() {
        let height = informationView.bounds.size.height
        let width = informationView.bounds.size.width
        let loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        loadingView.tag = 75
        informationView.addSubview(loadingView)
        self.informationView.isHidden = false
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
        if let viewWithTag = informationView.viewWithTag(50) {
            self.informationView.isHidden = true
            viewWithTag.removeFromSuperview()
        }
        
        self.tableView.beginUpdates()
        self.tableView.setContentOffset( CGPoint(x: 0.0, y: 0.0), animated: false)
        self.tableView.endUpdates()
        
        if let text = searchBar.text {
            artists = []
            configureLoadingView()
            tableView.reloadData()
            searchString = text
            resetSearchParameters()
            fetchData()
        }
        
        searchBar.resignFirstResponder()
    }
    
    //Note sure why this functions is never called
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return ArtistData.shared.getArtists()?.count ?? 0
        if totalCount == 1 {
            return 1
        } else {
            return totalCount - 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier) as! SearchCell
        if isLoadingCell(for: indexPath) {
            //Loading Cell View
        } else {
            cell.setDataFromModel(artists[indexPath.row])
        }
        
        return cell
    }
    
}

extension SearchResultsViewController: UITableViewDelegate {
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var buttonString: ButtonOptions
        
        if ArtistData.shared.favouriteArtists.contains(where: { $0.id == artists[indexPath.row].id }) {
            buttonString = .remove
        } else {
            buttonString = .favourite

        }
        
        let action =  UIContextualAction(style: .normal, title: buttonString.rawValue, handler: { (action,view,completionHandler ) in
            switch buttonString {
            case .favourite:
                ArtistData.shared.addNewFavourite(artist: self.artists[indexPath.row])
            case .remove:
                ArtistData.shared.removeNewFavourite(artist: self.artists[indexPath.row])
            }

            completionHandler(true)
        })
        action.backgroundColor = .black
        let confrigation = UISwipeActionsConfiguration(actions: [action])
        
        return confrigation
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        performSegue(withIdentifier: "showEvents", sender: cell)
    }
}

extension SearchResultsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            self.fetchData()
        }
    }
}

private extension SearchResultsViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.currentCount
    }
}
