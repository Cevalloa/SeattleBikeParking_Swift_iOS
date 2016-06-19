//
//  ViewController.swift
//  Seattle Bike Park
//
//  Created by Alex Cevallos on 11/5/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import UIKit
import MapKit

class ViewControllerMain: UIViewController, ViewControllerMainProtocol, CLLocationManagerDelegate {
    
    //MARK: IBOutlet Properties
    @IBOutlet weak var mapView: MapOfBikes! // Custom mapView class set for storyboard map
    @IBOutlet weak var buttonToResetMap: UIButton! // Used to reset button
    
    let locationManager = CLLocationManager()
    
    //MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad() // Do any additional setup after loading the view, typically from a nib.
        
        self.fetchBikeParkingData() // Makes network call -> Gets data from Seattle
        
        mapView.resetMapToViewEntireSeattle() // Sets map to view entire map
        mapView.drawDirectionRouteOnMap()
        
        methodApplyTheme()
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.showsUserLocation = true
    }
    
    //MARK: UI Layout Methods
    func methodApplyTheme() {
        
        self.buttonToResetMap.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        self.buttonToResetMap.layer.cornerRadius = 5 // Circular feel
        self.buttonToResetMap.layer.borderWidth = 1
        self.buttonToResetMap.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    //MARK: Network Methods
    func fetchBikeParkingData() {
        
        let proxy = WebServiceProxy { (returnedJSON, errorMessage) -> Void in
            
            let returnedJSONTwo = BikeSpotParser.methodCreateArrayOfBikeSpotModels(returnedJSON)
            
            // convert returned json into modelparkingspotbike
                for annotationTest in returnedJSONTwo {
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.mapView.addAnnotation(annotationTest)
                    })
                }
            
            if self.mapView.viewControllerMainProtocol == nil {
                
                self.mapView.viewControllerMainProtocol = self
            }
           // print(returnedJSON)
        }
        
        // Service layer calls HTTP request
        let bikeSpotService = BikeSpotService()
        bikeSpotService.methodGetRequestForBikeSpots(proxy)
    }
    
    // UIViewControllerMain Protocol Methods
    func protocolMapHasMoved() {
        
        // If the user moves the map, lets unhide the button
        self.buttonToResetMap.hidden = false
    }
    
    // IBAction Methods
    @IBAction func actionFindUserButtonPressed(sender: AnyObject) {
        
        // Check if user has given us location permission
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse {
            
            methodZoomInOnUserLocationIfAvailable()
        } else {
            
            // Tells user they need to renable their location
            methodDisplayLocaitonServiceDisabledAlert()
        }

    }
    
    @IBAction func actionResetMapButtonPressed(sender: AnyObject) {
        
        // On map reset, hide the button
        self.buttonToResetMap.hidden = true

        // In one second, animate from 0 alpha & hidden to 1 alpha and unhidden
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(methodShowButton), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
        // Finally reset entire map
        mapView.resetMapToViewEntireSeattle()
    }
    
    // MARK: Helper Methods
    
    // Hides and then reshows "reset map" button
    func methodShowButton() {
        
        // Hide alpha 0, then animate to 1
        self.buttonToResetMap.alpha = 0
        
        UIView.animateWithDuration(2.0) {
            self.buttonToResetMap.alpha = 1
            self.buttonToResetMap.hidden = false
        }
    }
    
    //Zooms in on user's location if it is available
    func methodZoomInOnUserLocationIfAvailable() {
        
        if mapView.showsUserLocation == false {
            
            mapView.showsUserLocation = true
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            let userLocation = mapView.userLocation
            
            if let locationUnwrapped = userLocation.location {
                
                let region = MKCoordinateRegionMakeWithDistance(
                    locationUnwrapped.coordinate, 200, 200)
                
                mapView.setRegion(region, animated: true)
            }
            
            
        }
    }
    
    // Tells user they need to renable their location
    func methodDisplayLocaitonServiceDisabledAlert() {
        
        let alertController = UIAlertController(title: "Location service disabled", message: "To re-enable, please go to Settings and turn on Location Service for this app.", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Sounds good!", style: UIAlertActionStyle.Default, handler: { (_) in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(alertAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

protocol ViewControllerMainProtocol {
    func protocolMapHasMoved()
}

