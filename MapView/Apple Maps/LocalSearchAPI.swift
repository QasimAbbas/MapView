//
//  LocalSearchAPI.swift
//  MapView
//
//  Created by Qasim Abbas on 8/13/18.
//  Copyright © 2018 Qasim. All rights reserved.
//

import Foundation
import MapKit

class LocalSearchAPI: NSObject{
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
    override init() {
        super.init()
    }
    
    func createLocalSearchRequest(){
        
        print("Creating Local Search")
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "restaurant"
        
        // Set the region to an associated map view's region
        request.region = (self.mapView?.region)!
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard response != nil else{
                return
            }
            
            self.matchingItems = (response?.mapItems)!
            self.createPins(items: self.matchingItems)
            
            print("ERROR \(String(describing: error))")
        }
    }
    
    func createSearchRequestWithKeywords(searchWords: String){
        print("Creating Local Search")
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchWords
        
        // Set the region to an associated map view's region
        request.region = (self.mapView?.region)!
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard response != nil else{
                return
            }
            
            self.matchingItems = (response?.mapItems)!
            self.createPins(items: [self.matchingItems.first!])
            
            print("ERROR \(String(describing: error))")
        }
    }
    
    func createPins(items: [MKMapItem]){
        for item in items{
    
            print(self.mapView?.description ?? "NO MAPVIEW PRESENT")
            self.createPinAnnotation(item: item)
//            self.mapView?.addAnnotation(item.placemark)
            self.mapView?.showAnnotations((self.mapView?.annotations)!, animated: true)
        }
        
    }
    
    func createPinAnnotation(item: MKMapItem){
        let location = item.placemark.coordinate
        let pin = MKPointAnnotation()
        pin.coordinate = location
        pin.title = item.name
        
        let customPin = CustomPinAnnotation(pin: pin, url: item.url?.absoluteString ?? "http://www.google.com" )
        DAO.sharedDAO.pinItems.append(customPin)
    
        self.mapView?.addAnnotation(pin)
    }
}
