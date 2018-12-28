//
//  ArtistsSearchVC.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class ArtistsSearchVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var ArtistsSearchTableView: UITableView!
    
    private var foundArtists = [Artist]()
    private var selectedArtist: Artist!
    private let pageManager = PageManager()
    private let taskManager = TaskManager()
    private let arrayType = [Artist].self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptySearchBar()
        ArtistsSearchTableView.tableFooterView = UIView()
    }
    
    func emptySearchBar(){
        self.spinner.stopAnimating()
        foundArtists = []
        ArtistsSearchTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ArtistsSearchTableView.reloadData()
    }

    enum DownloadsResult{
        case success
        case noResults
    }
    
    func requestExecutor(type: RequestType, result: ResultsPage){
        
        switch type{
        case .search:
            getArtists(result: result)
        case .pagination:
            moreArtists(result: result)
        }
        
    }
    
    func request(type: RequestType){
        do{
            let page = pageManager.page
            let requestURL = try ApiRouter.artistsSearch(searchParameter: searchBar.text, page: String(page)).asRequest()
            print(requestURL)
            taskManager.cancelTask(task: ApiService.shared.task)
            ApiService.shared.request(request: requestURL, type: ResultsPage.self) { (result) in
                switch result{
                case .success(let result):
                    self.requestExecutor(type: type, result: result)
                case .failure(let error):
                    print("error")
                    print(error)
                }
            }
        }catch{
            print("no data")
        }
    }
    
    func getArtists(result: ResultsPage){
        
        DispatchQueue.main.async {
    
            if !(self.searchBar.text?.isEmpty ?? true){

                ArrayManager.shared.arrayAction(type: self.arrayType, result: result, action: { (array) in
                    self.foundArtists = array
                }, elseAction: {
                    self.foundArtists = []
                })

                if let total = result.resultsPage.totalEntries {
                    self.pageManager.totalResults = total
                }
                
                self.ArtistsSearchTableView.reloadDataAndScrollToTop {
                    
                    if result.resultsPage.totalEntries == 0 {
                        self.stopDownload(result: .noResults)
                    }else{
                        self.stopDownload(result: .success)
                    }
                }
                
            }
        }
    }
    
    func moreArtists(result: ResultsPage){
        DispatchQueue.main.async {
            ArrayManager.shared.arrayAction(type: self.arrayType, result: result, action: { (array) in
                self.foundArtists += array
                self.ArtistsSearchTableView.reloadData()
            })
        }
    }

    func startDownload(){
        resultsLabel.isHidden = true
        ArtistsSearchTableView.isHidden = true
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    func stopDownload(result: DownloadsResult){
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.ArtistsSearchTableView.isHidden = false
            case .noResults:
                self.resultsLabel.isHidden = false
            }
            self.spinner.stopAnimating()
        }
    }
    
    func search(){
        
        pageManager.resetPageCounting()
        
        if !(searchBar.text?.isEmpty ?? true){
            startDownload()
            request(type: .search)
        }else{
            emptySearchBar()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArtistsDetailsVC {
            destination.currentArtist = selectedArtist
        }
    }
}

extension ArtistsSearchVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundArtists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistsSearchTVCell") as! ArtistsSearchTVCell
        
        let currentArtist = foundArtists[indexPath.row]
        
        cell.artist = currentArtist
        cell.addArtistToFavourites.tag = indexPath.row
        cell.addArtistToFavourites.addTarget(self, action: #selector(addToFavourites(_:)), for: .touchUpInside)
        
        if FavouritesArtists.shared.list.contains(currentArtist){
            cell.addArtistToFavourites.setImage(#imageLiteral(resourceName: "starFilled"), for: .normal)
        }else{
            cell.addArtistToFavourites.setImage(#imageLiteral(resourceName: "starUnfilled"), for: .normal)
        }
        
        pagination(indexPath: indexPath)
        
        return cell
        
    }
    
    func pagination(indexPath: IndexPath){
        if indexPath.row == foundArtists.count - 1 {
            pageManager.nextPage {
                request(type: .pagination)
            }
        }
    }
    
}

extension ArtistsSearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArtist = foundArtists[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    @objc func addToFavourites (_ sender: UIButton){
        
        if !FavouritesArtists.shared.list.contains(foundArtists[sender.tag]){
            FavouritesArtists.shared.list.append(foundArtists[sender.tag])
        }else{
            FavouritesArtists.shared.list.delete(foundArtists[sender.tag])
        }
        ArtistsSearchTableView.reloadData()
    }
    
}

extension ArtistsSearchVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search()
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
