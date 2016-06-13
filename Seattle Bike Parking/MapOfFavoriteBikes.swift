//
//  MapOfFavoriteBikes.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 6/13/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit

class MapOfFavoriteBikes: MKMapView, MKMapViewDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.delegate = self
    }
}
