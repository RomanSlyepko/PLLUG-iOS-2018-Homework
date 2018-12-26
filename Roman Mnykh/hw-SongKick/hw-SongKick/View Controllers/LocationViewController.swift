//
//  LocationViewController.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/25/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var eventModels: [EventModel] = []
    var regionRadius: CLLocationDistance = 500

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func configureMapView() {
        mapView.delegate = self
        if let location = eventModels.first?.location, eventModels.count == 1 {
            let initialLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            centerMapOnLocation(location: initialLocation)
        }
        createAnnotations()
    }
    
    func createAnnotations() {
        eventModels.forEach { model in
            let annotation = EventAnnotation(title: model.displayName,
                                             locationName: model.venue.displayName,
                                             coordinate: CLLocationCoordinate2D(latitude: model.location.latitude, longitude: model.location.longitude))
            mapView.addAnnotation(annotation)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension LocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? EventAnnotation else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            //view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
