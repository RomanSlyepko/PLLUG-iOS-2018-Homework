//
//  AllEventsMapViewController.swift
//  SongKick
//
//  Created by user on 12/24/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit
import MapKit

class AllEventsMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 4000000
    var events = [Event]()
    var eventsAnnotation = [EventAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let latitude = events[0].location.lat, let longtitude = events[0].location.lng {
            let initLocation = CLLocation(latitude: latitude, longitude: longtitude)
            centerMapOnLocation(location: initLocation)
        }
        setMarkers()
    }
    
    func setMarkers() {
        for event in events {
            guard let lat = event.location.lat, let long = event.location.lng else { continue }
            let annotation = EventAnnotation(title: event.location.city, detail: event.start.date, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
            eventsAnnotation.append(annotation)
        }
        mapView.addAnnotations(eventsAnnotation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
