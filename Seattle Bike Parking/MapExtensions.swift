//
//  MapExtensions.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 6/13/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    
    // MARK: Map manipulation methods
    
    // Rests map to the center of Seattle
    func resetMapToViewEntireSeattle() {
        
        let centerOfSeattle = CLLocation(latitude: MapKitConstants.SeattleCenter_latitude.rawValue, longitude: MapKitConstants.SeattleCenter_longitude.rawValue)
        
        self.centerMapOnLocation(centerOfSeattle)
    }
    
    // Centers the map on a specific location
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  MapKitConstants.regionRadius.rawValue * 2.0, MapKitConstants.regionRadius.rawValue * 2.0)
        self.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: Direction Methods
    func drawDirectionRouteOnMap() {
        
        // !!! NOTE !!! Static for right now, will change to dynamic
        
        let startingSpot = MKPlacemark(coordinate: CLLocationCoordinate2DMake(MapKitConstants.SeattleCenter_latitude.rawValue, MapKitConstants.SeattleCenter_longitude.rawValue), addressDictionary: nil)
        
        let endingSpot = MKPlacemark(coordinate: CLLocationCoordinate2DMake(47.6232, -122.3204), addressDictionary: nil)
        
        let mapService = MapService(startingLocation: MKMapItem(placemark: startingSpot), endingLocation: MKMapItem(placemark: endingSpot)) { (route) -> Void in
            self.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
        }
        
        mapService.requestNetworkConnectionForDirectionsRoute()
    }
    
    // MARK: Annotation Creation Methods
    
    // Creates
    
    // Physical draws the line view
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polyLine = overlay
        let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
        polyLineRenderer.strokeColor = UIColor.blueColor()
        polyLineRenderer.lineWidth = 2.0
        
        return polyLineRenderer
    }
}
