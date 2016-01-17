//
//  MapService.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 1/16/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit

class MapService {
    
    // MARK: TypeAliases
    typealias CompletitionHandler = (route: MKRoute) -> Void
    
    // MARK: Member Variables
    let completionHandler: CompletitionHandler?
    let directions: MKDirections
    
    // MARK: Initializers
    init(startingLocation: MKMapItem, endingLocation: MKMapItem, completionWithCalculatedDirections: CompletitionHandler?) {
        
        let request: MKDirectionsRequest = MKDirectionsRequest()
        request.source = startingLocation
        request.destination = endingLocation
        request.transportType = MKDirectionsTransportType.Walking
        
        self.directions = MKDirections(request: request)
        
        self.completionHandler = completionWithCalculatedDirections
    }
    
    // MARK: Connection Methods
    func requestNetworkConnectionForDirectionsRoute() {
        
        self.directions.calculateDirectionsWithCompletionHandler { (response: MKDirectionsResponse?, error: NSError?) -> Void in
            
            let directionsResponse: MKDirectionsResponse = response!
            let routeFinished = directionsResponse.routes[0] as MKRoute
            
            if let returnCompletedHandler = self.completionHandler {
                
                returnCompletedHandler(route: routeFinished)
            }
        }
    }
}