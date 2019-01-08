//
//  LocationViewController.swift
//  SongKick
//
//  Created by Roman on 12/27/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var concertLocationMapView: MKMapView!

    var venue: [Venue?]?
    private var annotation: [Annotation]?

    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpAnnotations()
    }

    // MARK: - Config UI
    fileprivate func setUpAnnotations() {
        self.annotation = self.venue?.compactMap { Annotation(title: $0?.name ?? "",
                                                              coordinate: CLLocationCoordinate2DMake($0?.latitude ?? 0,
                                                                                                     $0?.longtitude ?? 0)) }
        if self.annotation?.count ?? 0 > 1 {
            self.title = "Venues"
        } else {
            self.title = self.annotation?[0].title
        }

        let radius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: (self.annotation?[0].coordinate)!,
                                                  latitudinalMeters: radius,
                                                  longitudinalMeters: radius)
        self.concertLocationMapView.setRegion(coordinateRegion, animated: true)
        dump(self.annotation!)
        self.annotation?.forEach {
            self.concertLocationMapView.addAnnotation($0)
        }
    }

}
