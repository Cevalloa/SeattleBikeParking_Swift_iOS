//
//  MapController.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 12/6/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit

class MapViewBikes: MKMapView {
    
    // MARK: Initializer Methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func resetMapToViewEntireSeattle() {
        
        let centerOfSeattle = CLLocation(latitude: MapKitConstants.SeattleCenter_latitude.rawValue, longitude: MapKitConstants.SeattleCenter_longitude.rawValue)
        
        self.centerMapOnLocation(centerOfSeattle)
        
    }

    func centerMapOnLocation(location: CLLocation) {
                
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            MapKitConstants.regionRadius.rawValue * 2.0, MapKitConstants.regionRadius.rawValue * 2.0)
        self.setRegion(coordinateRegion, animated: true)
    }

}