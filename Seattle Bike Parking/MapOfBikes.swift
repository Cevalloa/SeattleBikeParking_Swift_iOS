//
//  MapController.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 12/6/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit

class MapOfBikes: MKMapView, UIGestureRecognizerDelegate {
    
    var viewControllerMainProtocol: ViewControllerMainProtocol?
    
    // MARK: Initializer Methods
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.delegate = self
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(methodUserMovedMap))
        panRecognizer.delegate = self
        self.addGestureRecognizer(panRecognizer)
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func methodUserMovedMap() {
        print("called map change")
        if let viewControllerMainProtocolUnwrapped = viewControllerMainProtocol {
            
            viewControllerMainProtocolUnwrapped.protocolMapHasMoved()
        }
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
                view.calloutOffset = CGPoint(x: -10, y: 0)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                //view.pinTintColor = UIColor(red:10/255, green:204/255, blue:56/255, alpha:1.0)
            }
            
            return view
        }
        
        return nil
    }
    
    // Called when annotation callout button is pressed
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let annotationClicked = view.annotation as! ParkingBikeSpotModel
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var updatedArray = [NSKeyedArchiver.archivedDataWithRootObject(annotationClicked)]
        
        if let arrayOfFavoritesCurrently = userDefaults.objectForKey("arrayOfFavoriteBikeSpots") as? [NSData] {
            
            updatedArray = [NSKeyedArchiver.archivedDataWithRootObject(annotationClicked)] + arrayOfFavoritesCurrently
        }
        
        userDefaults.setObject(updatedArray, forKey: "arrayOfFavoriteBikeSpots")
        
        userDefaults.synchronize()
        
        print(annotationClicked.title)

    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
//        
//        let userLocation = mapView.userLocation
//        
//        let region = MKCoordinateRegionMakeWithDistance(
//            userLocation.location!.coordinate, 200, 200)
//        
//        mapView.setRegion(region, animated: true)
    }
}




