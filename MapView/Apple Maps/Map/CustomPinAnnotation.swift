//
//  CustomPinAnnotation.swift
//  MapView
//
//  Created by Qasim Abbas on 8/13/18.
//  Copyright © 2018 Qasim. All rights reserved.
//

import Foundation
import MapKit

class CustomPinAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var url: String?
    
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    init(pin: MKPointAnnotation) {
        self.coordinate = pin.coordinate
        self.title = pin.title
        self.subtitle = pin.subtitle
    }
    
    init(pin: MKPointAnnotation, url: String) {
        self.coordinate = pin.coordinate
        self.title = pin.title
        self.subtitle = pin.subtitle
        self.url = url
    }
    
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, url: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.url = url
    }
    
}
