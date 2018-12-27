//
//  ArtistInfoViewController.swift
//  SongKick
//
//  Created by Roman on 12/24/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit

class ArtistInfoViewController: UIViewController {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var dateUntilArtistOnTourLabel: UILabel!
    @IBOutlet weak var eventsTableView: UITableView!
    var artist: Artist?
    var concert: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initLabels()
        configDelegates()
        self.registerCells()
        
        self.searchCalendar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    fileprivate func searchCalendar() {
        guard let id = self.artist?.id else { return }
        NetworkManager.shared.getCalendar(for: id) {
            switch $0 {
            case .success(let result):
                DispatchQueue.main.async {
                    guard let events = result.event else { return }
                    DataStorager.shared.artistEvents = events
                    self.eventsTableView.reloadData()
                    print(DataStorager.shared.artistEvents)
                }
            case .error(let err):
                Alert.showErrorAlert(on: self, message: err.rawValue)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.showLocation.rawValue:
            guard let vc = segue.destination as? LocationViewController else { return }
            vc.concert = self.concert
        default:
            return
        }
    }
}

// MARK: -UITableViewDataSource
extension ArtistInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorager.shared.artistEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.eventsTableView.dequeueReusableCell(withIdentifier: ConcertLocationTableViewCell.identifier) as! ConcertLocationTableViewCell
        let event = DataStorager.shared.artistEvents[indexPath.row]
        cell.concertDate.text = event.startData?.date
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
        self.concert = DataStorager.shared.artistEvents[indexPath.row].location

        performSegue(withIdentifier: Segues.showLocation.rawValue, sender: self)
    }
}
