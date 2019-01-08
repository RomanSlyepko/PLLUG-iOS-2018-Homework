//
//  ArtistInfoViewController.swift
//  SongKick
//
//  Created by Roman on 12/24/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit

class ArtistInfoViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var dateUntilArtistOnTourLabel: UILabel!
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var seeAllEventsButton: UIButton!
    @IBOutlet weak var onTourLabel: UILabel!

    var artist: Artist?
    private var page: Int = 1
    private var maximumPages: Int = 1
    private var events = [Event]()
    private var venues: [Venue?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initLabels()
        self.configDelegates()
        self.registerCells()
        
        self.searchCalendar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.eventsTableView.reloadData()
    }
    
    fileprivate func searchCalendar() {
        guard let id = self.artist?.id else { return }
        NetworkManager.shared.getCalendar(for: id) {
            switch $0 {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let events = data.results?.event else { return }
                    self.maximumPages = data.totalEntries / data.perPage + 1
                    self.events = events
                    self.eventsTableView.reloadData()
                }
            case .error(let err):
                Alert.showErrorAlert(on: self, message: err.rawValue)
            }
        }
    }

    fileprivate func searchCalendarPage() {
        guard let id = self.artist?.id else { return }
        self.page += 1
        if self.page <= self.maximumPages {
            NetworkManager.shared.getCalendarPage(for: id, page: self.page) {
                switch $0 {
                case .success(let data):
                    DispatchQueue.main.async {
                        guard let events = data.results?.event else { return }
                        self.events += events
                        self.eventsTableView.reloadData()
                    }
                case .error(let error):
                    Alert.showErrorAlert(on: self, message: error.rawValue)
                }
            }
        }
    }

    
    fileprivate func initLabels() {
        self.artistNameLabel.text = self.artist?.name
        self.dateUntilArtistOnTourLabel.text = self.artist?.onTourUntil
    }
    
    fileprivate func registerCells() {
        let nib = UINib(nibName: ConcertLocationTableViewCell.identifier, bundle: nil)
        self.eventsTableView.register(nib, forCellReuseIdentifier: ConcertLocationTableViewCell.identifier)
    }
    
    fileprivate func configDelegates() {
        self.eventsTableView.delegate = self
        self.eventsTableView.dataSource = self
    }

    @IBAction func showAllVenues(_ sender: Any) {
        if !self.events.isEmpty {
             performSegue(withIdentifier: Segues.showAllLocations.rawValue, sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.showLocation.rawValue:
            guard let vc = segue.destination as? LocationViewController else { return }
            vc.venue = self.venues
        case Segues.showAllLocations.rawValue:
            guard let vc = segue.destination as? LocationViewController else { return }
            vc.venue = self.events.map { $0.venue }
        default:
            return
        }
    }
}

// MARK: -UITableViewDataSource
extension ArtistInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.eventsTableView.dequeueReusableCell(withIdentifier: ConcertLocationTableViewCell.identifier) as! ConcertLocationTableViewCell
        let event = self.events[indexPath.row]
        cell.concertDate.text = event.startDate?.date
        cell.concertName.text = event.name
        cell.concertLocation.text = event.location?.city
        
        return cell
    }
}

// MARK: -UITableViewDelegate
extension ArtistInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.venues = [self.events[indexPath.row].venue]

        performSegue(withIdentifier: Segues.showLocation.rawValue, sender: self)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.events.count - 1 {
            self.searchCalendarPage()
        }
    }
}
