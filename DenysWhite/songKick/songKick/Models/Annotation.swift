//
//  Annotation.swift
//  songKick
//
//  Created by Denys White on 12/26/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
}
