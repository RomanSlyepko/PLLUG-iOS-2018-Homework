//
//  EventAnnotation.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/25/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation

import MapKit

class EventAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
