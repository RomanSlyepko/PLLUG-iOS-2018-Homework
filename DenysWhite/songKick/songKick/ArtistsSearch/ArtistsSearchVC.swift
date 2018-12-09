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
    
    var foundArtists = [Artist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptySearchBar()
        ArtistsSearchTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ArtistsSearchTableView.reloadData()
    }
    
    enum requestType{
        case search
        case pagination
    }
    
    enum DownloadsResult{
        case success
        case noResults
    }
    
    func requestExecutor(type: requestType, result: ResultsPage){
        
        switch type{
        case.search:
            getArtists(result: result)
        case .pagination:
            moreArtists(result: result)
        }
        
    }
    
    func request(type: requestType){
        do{
            let page = PageManager.shared.page
            let requestURL = try ApiRouter.artistsSearch(searchParameter: searchBar.text, page: String(page)).asRequest()
            print(requestURL)
            
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
                
                self.foundArtists = result.resultsPage.results.artist
                PageManager.shared.totalResults = result.resultsPage.totalEntries
                
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
            self.foundArtists += result.resultsPage.results.artist
            self.ArtistsSearchTableView.reloadData()
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
                self.spinner.stopAnimating()
                self.ArtistsSearchTableView.isHidden = false
            case .noResults:
                self.spinner.stopAnimating()
                self.resultsLabel.isHidden = false
            }
        }
    }
    
    func emptySearchBar(){
        self.spinner.stopAnimating()
        foundArtists = []
        ArtistsSearchTableView.reloadData()
    }
    
    func search(){
        
        PageManager.shared.resetPageCounting()
        
        if !(searchBar.text?.isEmpty ?? true){
            startDownload()
            request(type: .search)
        }else{
            emptySearchBar()
        }
        
    }
    
}
