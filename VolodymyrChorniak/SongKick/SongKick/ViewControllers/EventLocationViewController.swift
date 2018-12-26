//
//  EventLocationViewController.swift
//  SongKick
//
//  Created by user on 12/24/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit
import MapKit

class EventLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    var event: Event?
    let regionRadius: CLLocationDistance = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let currentEvent = event {
            eventNameLabel.text = currentEvent.displayName
            navigationItem.title = currentEvent.venue.displayName
            configurateMap()
        }
    }
    
    func configurateMap() {
        guard let event = event else { return }
        if let latitude = event.location.lat, let longtitude = event.location.lng {
            let initLocation = CLLocation(latitude: latitude, longitude: longtitude)
            centerMapOnLocation(location: initLocation)
            
            let event = EventAnnotation(title: event.location.city, detail: event.start.date, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longtitude))
            mapView.addAnnotation(event)
        } else {
            showAlert()
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Unable to show location on map", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
