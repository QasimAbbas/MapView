//
//  GoogleViewController.swift
//  MapView
//
//  Created by Qasim Abbas on 8/13/18.
//  Copyright © 2018 Qasim. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleViewController: UIViewController, GMSMapViewDelegate {
    let appleStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
   
    // You don't nvar to modify the default init(nibName:bundle:) method.
    
    var resultSearchController: UISearchController? = nil

    @IBOutlet weak var googleMapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.7086, longitude: -74.0149, zoom: 16)
        
        print(googleMapView)
        //       let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        googleMapView.camera = camera
        googleMapView.delegate = self
        
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 40.7086, longitude: -74.0149)
        marker.title = "TurnToTech"
        marker.snippet = "New York"
        marker.map = googleMapView
        
        setupSearch()

        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        let vc = appleStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let navigationController = NavViewController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
        
    }
    
    func setupSearch() {
        
        let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "GoogleLocationSearchTable") as! GoogleLocationSearchTable
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
       // locationSearchTable.handleMapSearchDelegate = self
        
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        self.navigationItem.titleView = searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
    }
    
    

    @IBAction func segmentController(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            
            googleMapView.mapType = .normal
            break
        case 1:
            googleMapView.mapType = .hybrid
            break
        case 2:
            googleMapView.mapType = .satellite
        default:
            
            break
        }
        
    }
    
}
