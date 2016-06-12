//
//  MapController.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 12/6/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit

class MapOfBikes: MKMapView {
    
    // MARK: Initializer Methods
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
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

// MapView Delegate Methods
extension MapOfBikes: MKMapViewDelegate {
    
    //MARK: Annotation Delegate Methods

    // Used like TableView.CellForRowAtIndexPath
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ParkingBikeSpotModel {
            
            let identifier = "bikeRack"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else { // We couldn't dequeue the annotation
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            
            return view
        }
        
        return nil
    }
    
    // Called when annotation callout button is pressed
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let annotationClicked = view.annotation as! ParkingBikeSpotModel
        

    }
}




