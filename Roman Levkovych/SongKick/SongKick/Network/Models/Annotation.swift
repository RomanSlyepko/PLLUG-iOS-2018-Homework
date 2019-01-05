//
//  Annotation.swift
//  SongKick
//
//  Created by Roman on 12/29/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }

    func mapItem() -> MKMapItem {
        let placemark = MKPlacemark(coordinate: self.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title

        return mapItem
    }
}
