//
//  EventsTVC.swift
//  songKick
//
//  Created by Denys White on 12/25/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class EventsTVC: UITableViewController {
    
    @IBOutlet weak var showAllButton: UIBarButtonItem!
    
    private var artistEvents = [Event]()
    private var selectedEvent: Event!
    var currentArtist: Artist!
    private var showAll = Bool()
    private let pageManager = PageManager()
    private let arrayType = [Event].self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        showAll = false
    }
    
    func setup(){
        tableView.tableFooterView = UIView()
        request(type: .search)
    }
    
    @IBAction func showAllEventsOnMap(_ sender: Any) {
        showAll = true
        performSegue(withIdentifier: "showMap", sender: self)
    }
    
    func request(type: RequestType){
        do{
            let page = pageManager.page
            
            guard let href = currentArtist.identifier[0].eventsHref else { return }
            
            let requestURL = try ApiRouter.eventsShow(href: href, page: String(page)).asRequest()
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
    
    func requestExecutor(type: RequestType, result: ResultsPage){
        switch type{
        case.search:
            getEvents(result: result)
        case .pagination:
            moreEvents(result: result)
        }
    }
    
    func getEvents(result: ResultsPage){
        DispatchQueue.main.async {
            
            ArrayManager.shared.arrayAction(type: self.arrayType, result: result, action: { (array) in
                self.artistEvents = array
            }, elseAction: {
                self.artistEvents = []
            })

            if let total = result.resultsPage.totalEntries {
                self.pageManager.totalResults = total
            }
            self.tableView.reloadData()
            self.pagination()
        }
    }
    
    func moreEvents(result: ResultsPage){
        DispatchQueue.main.async {
            ArrayManager.shared.arrayAction(type: self.arrayType, result: result, action: { (array) in
                self.artistEvents += array
                self.tableView.reloadData()
                self.pagination()
            })
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistEvents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        
        let currentEvent = artistEvents[indexPath.row]
        
        cell.textLabel?.text = "\(currentEvent.type): \(currentEvent.displayName)"
        cell.detailTextLabel?.text = detailsText(currentEvent: currentEvent)
        
        return cell
    }
    
    func detailsText(currentEvent: Event)->String{
        var date = String()
        if let fullDate = currentEvent.start?.stringFullDate{
            date = fullDate
        }else{
            if let onlyDate = currentEvent.start?.stringDate{
                date = onlyDate
            }else{
                date = "Unknown"
            }
        }
        return "City: \(currentEvent.location.city)\nVenue: \(currentEvent.venue.displayName)\nDate: \(date)"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = artistEvents[indexPath.row]
        if selectedEvent.location.lat != nil || selectedEvent.location.lng != nil {
            performSegue(withIdentifier: "showMap", sender: self)
        }else{
            Alert.shared.alert(title: "Can't show on the map", message: "Sorry, we have not enought information about this event", button: "OK", sender: self, action: nil)
        }
    }
    
    func pagination(){
        pageManager.nextPage {
            request(type: .pagination)
        }
        if pageManager.isLastPage {
            showAllButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MapVC {
            destination.currentEvent = selectedEvent
            destination.currentEvents = artistEvents
            destination.showAll = showAll
        }
    }
}
