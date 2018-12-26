//
//  EventsViewController.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/24/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var artistModel: ArtistModel?
    var eventModels: [EventModel] = []
    
    var isFetchInProgress: Bool = false
    var currentPage: Int = 1
    var currentCount: Int = 0
    var totalCount: Int = 0
    let perPage: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchData()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
       // print(artistName)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? EventInfoCell,
            let indexPath = tableView.indexPath(for: cell),
            let destination = segue.destination as? LocationViewController {
 
            destination.eventModels = [eventModels[indexPath.row]]

        } else if let _ = sender as? UIButton, let destination = segue.destination as? LocationViewController {
                destination.eventModels = eventModels
        }
    }
    
    private func fetchData() {
        guard !isFetchInProgress else { return }
        
        RequestManager.shared.getSongKickData(request: SongKickRouter.getEvents(for: artistModel!.displayName, perPage: perPage, page: currentPage)) {
            switch $0 {
            case .success(let model):
                self.eventModels.append(contentsOf: model.resultsPage.results.event ?? [])
                self.totalCount = model.resultsPage.totalEntries
                self.tableView.reloadData()
            case .failure(_):
                break
            }
            
            self.isFetchInProgress = false
            self.currentPage += 1
            if self.totalCount > self.currentCount + self.perPage {
                self.currentCount += self.perPage
            } else {
                self.currentCount = self.totalCount
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: ArtistInfoCell.identifier, bundle: nil), forCellReuseIdentifier: ArtistInfoCell.identifier)
        tableView.register(UINib(nibName: EventInfoCell.identifier, bundle: nil), forCellReuseIdentifier: EventInfoCell.identifier)
    }

}

extension EventsViewController: UITableViewDataSource, EventsButtonDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return totalCount
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ArtistInfoCell.identifier) as! ArtistInfoCell
            if let artistModel = artistModel {
                cell.setDataFromModel(artistModel, numberOfEvents: totalCount)
            }
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventInfoCell.identifier) as! EventInfoCell
            if isLoadingCell(for: indexPath) {
                //LoadingCellView
            } else {
                cell.setDataFromModel(eventModels[indexPath.row])
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Events"
        }
        
        return nil
    }
    
    func eventsButtonTapped(sender: UIButton) {
        performSegue(withIdentifier: "mapSegue", sender: sender)

    }
    
}

extension EventsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150.0
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section != 0 else { return }
        
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        performSegue(withIdentifier: "mapSegue", sender: cell)
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        guard indexPath.section == 0, let artistModel = artistModel else { return nil }
        
        var buttonString: ButtonOptions
        
        if ArtistData.shared.favouriteArtists.contains(where: { $0.id == artistModel.id }) {
            buttonString = .remove
        } else {
            buttonString = .favourite
            
        }
        
        let action =  UIContextualAction(style: .normal, title: buttonString.rawValue, handler: { (action,view,completionHandler ) in
            switch buttonString {
            case .favourite:
                ArtistData.shared.addNewFavourite(artist: artistModel)
            case .remove:
                ArtistData.shared.removeNewFavourite(artist: artistModel)
            }
            
            completionHandler(true)
        })
        action.backgroundColor = .black
        let confrigation = UISwipeActionsConfiguration(actions: [action])
        
        return confrigation
    }
}

extension EventsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            self.fetchData()
        }
    }
}

private extension EventsViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.currentCount
    }
}


