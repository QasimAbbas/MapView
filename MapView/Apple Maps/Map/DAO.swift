//
//  DAO.swift
//  MapView
//
//  Created by Qasim Abbas on 8/13/18.
//  Copyright © 2018 Qasim. All rights reserved.
//

import Foundation



class DAO{
    static let sharedDAO = DAO()
    
    var localSearchAPI: LocalSearchAPI?
    var pinItems: [CustomPinAnnotation]
    init() {
        pinItems = [CustomPinAnnotation]()
        localSearchAPI = LocalSearchAPI()
    }
    
}
