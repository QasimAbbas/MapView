//
//  ViewController.swift
//  MapView
//
//  Created by Qasim Abbas on 8/1/18.
//  Copyright © 2018 Qasim. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate{

    var locationManager: CLLocationManager = CLLocationManager()
    var gesture: UIGestureRecognizer?
    var pinURL: String?
    var resultSearchController: UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        addPins()
        
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        locationSearchTable.handleMapSearchDelegate = self
        
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        self.navigationItem.titleView = searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 250, 250)
        self.mapView.setRegion(region, animated: true)
    }

    @IBAction func segmentController(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
           
            mapView.mapType = .standard
            break
        case 1:
            mapView.mapType = .hybrid
            break
        case 2:
            mapView.mapType = .satellite
        default:
            
            break
        }
        
    }
    
    

    
    func addPins(){
        
        let location =  CLLocationCoordinate2D(latitude: 40.7086, longitude: -74.0149)
        let turnToTechPin = MKPointAnnotation()
        turnToTechPin.coordinate = location
        turnToTechPin.title = "TurnToTech"
        
        mapView.addAnnotation(turnToTechPin)
        mapView.centerCoordinate = turnToTechPin.coordinate
    
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            print("error")
            return nil
        }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
        } else {
            annotationView!.annotation = annotation
        }

        annotationView!.canShowCallout = true
    
        let imageView = UIImageView(image: UIImage(named: "turntotechlogo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        annotationView?.leftCalloutAccessoryView = imageView
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.removeGestureRecognizer(gesture!)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        gesture = UITapGestureRecognizer(target: self, action: #selector(calloutTapped(tapGestureRecognizer:)))
        print(String(describing: view.annotation?.title))
        
        pinURL = DAO.sharedDAO.pinItems.filter({ (custompin) -> Bool in
            return custompin.title == view.annotation?.title
        }).first?.url
        
        view.addGestureRecognizer(gesture!)
    }
    
    @objc func calloutTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let state = tapGestureRecognizer.state
        if(state == UIGestureRecognizerState.ended || state == UIGestureRecognizerState.changed){
            let navVC = storyboard?.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
            let firstVC = navVC.topViewController as! WebViewController
            firstVC.urlString = pinURL ?? "http://www.google.com"
            
            //vc.urlString = "http://www.apple.com"
            navVC.modalTransitionStyle = .crossDissolve
            present(navVC, animated: true, completion: nil)
    
        }
    }
    
    
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: \(location)")
            DAO.sharedDAO.localSearchAPI?.mapView = self.mapView
            DAO.sharedDAO.localSearchAPI?.createLocalSearchRequest()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

extension ViewController: MapSearch{
    func mapDropPin(placemark: MKPlacemark) {
        mapView.removeAnnotations(mapView.annotations)
        selectedPin = placemark
        mapView.selectAnnotation(selectedPin!, animated: true)
    }
    
    
}



