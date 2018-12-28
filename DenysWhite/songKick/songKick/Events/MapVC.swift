//
//  MapVC.swift
//  songKick
//
//  Created by Denys White on 12/25/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    var currentEvent: Event!
    var currentEvents = [Event]()
    var showAll = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMarks()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent {
            let annotationsToRemove = map.annotations.filter { $0 !== map.userLocation }
            map.removeAnnotations( annotationsToRemove )
        }
    }
    
    func showMarks(){
        var span = MKCoordinateSpan()
        var location = CLLocationCoordinate2D()
        var region = MKCoordinateRegion()
        
        if showAll {
            var annotations = [Annotation]()
            for event in currentEvents {
                guard let latitude = event.location.lat, let longitude = event.location.lng else { continue }
                location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let annotation = Annotation(coordinate: location, title: event.displayName)
                annotations.append(annotation)
            }
            span = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
            region = MKCoordinateRegion(center: location, span: span)
            map.setRegion(region, animated: true)
            map.addAnnotations(annotations)
        }else{
            guard let latitude = currentEvent.location.lat, let longitude = currentEvent.location.lng else { return }
            span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            location = CLLocationCoordinate2DMake(latitude, longitude)
            region = MKCoordinateRegion(center: location, span: span)
            map.setRegion(region, animated: true)
            let annotation = Annotation(coordinate: location, title: currentEvent.displayName)
            map.addAnnotation(annotation)
        }
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKMarkerAnnotationView()
        guard let annotation = annotation as? Annotation else { return nil }
        let identifier = "identifier"
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            annotationView = dequedView
        }else{
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView.clusteringIdentifier = identifier
        return annotationView
    }
}
