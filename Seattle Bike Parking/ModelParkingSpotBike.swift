//
//  BikeParkingSpot.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 1/16/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class ModelParkingSpotBike: NSObject, MKAnnotation {
 
    var title: String?
    var subTitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, subTitle: String?, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.coordinate = coordinate
        self.subTitle = subTitle
    }
}

