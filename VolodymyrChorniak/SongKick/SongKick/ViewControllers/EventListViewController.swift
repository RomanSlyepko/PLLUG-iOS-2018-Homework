//
//  EventListViewController.swift
//  SongKick
//
//  Created by user on 12/24/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {
    
    @IBOutlet weak var showEventMapButton: UIButton!
    @IBOutlet weak var infoAboutEvents: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let dataManager = DataManager()
    var artist: Artist?
    var events: Events?
    var allEvents = [Event]()
    
    var page = 1
    var total = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Some artist have link on events page, but there not event if onTourUntil == nil
        // Some artist on tour, but they do not have a page with events
        
        guard let identifier = artist?.identifier else { return }
        if identifier.isEmpty || artist?.onTourUntil == nil {
            infoAboutEvents.text = "No events"
        } else {
            loadData()
        }
    }

    
    func loadData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let mbid = artist?.identifier[0].mbid else { return }
        dataManager.showEventsForArtist(withMbid: mbid, page: page, completion: { (event) in
            DispatchQueue.main.async {
                self.events = event
                self.allEvents += event.resultsPage.results.event
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.tableView.reloadData()
                if self.events != nil {
                    self.setEvent()
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.showAlert()
            }
            print(error.localizedDescription)
        }
    }
    
    func setEvent() {
        guard let totalEntries = self.events?.resultsPage.totalEntries else { return }
        infoAboutEvents.text = "\(totalEntries) Events"
        showEventMapButton.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            let mapVC = segue.destination as? AllEventsMapViewController
            mapVC?.events = allEvents
        } else {
            guard let indexPathRow = tableView.indexPathForSelectedRow?.row else { return }
            let eventLocationVC = segue.destination as? EventLocationViewController
            eventLocationVC?.event = allEvents[indexPathRow]
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Erorr loading events data", message: "Please, check your internet connection and try agin.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text = allEvents[indexPath.row].location.city
        cell.detailTextLabel?.text = allEvents[indexPath.row].displayName
        return cell
    }
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let totalEntries = events?.resultsPage.totalEntries else { return }
        if totalEntries > total {   // loading all events for map
            page += 1
            total += 50
            loadData()
        }
    }
}
