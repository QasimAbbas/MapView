//
//  CustomMarker.swift
//  MapView
//
//  Created by Qasim Abbas on 8/14/18.
//  Copyright © 2018 Qasim. All rights reserved.
//

import Foundation
import GoogleMaps

class CustomMarker: GMSMarker{
    var imageView: UIImageView?
    
    override init() {
        super.init()
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
       
    }
}
