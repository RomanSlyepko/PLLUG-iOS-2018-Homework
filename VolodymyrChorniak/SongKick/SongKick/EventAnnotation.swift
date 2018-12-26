//
//  EventAnnotation.swift
//  SongKick
//
//  Created by user on 12/24/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation
import MapKit

class EventAnnotation: NSObject, MKAnnotation {
    let title: String?
    let detail: String
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, detail: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.detail = detail
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return detail
    }
}
