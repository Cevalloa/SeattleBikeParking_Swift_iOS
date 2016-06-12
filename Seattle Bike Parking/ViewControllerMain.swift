//
//  ViewController.swift
//  Seattle Bike Park
//
//  Created by Alex Cevallos on 11/5/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import UIKit
import MapKit

class ViewControllerMain: UIViewController {
    
    //MARK: IBOutlet Properties
    @IBOutlet weak var mapView: MapOfBikes! // Custom mapView class set for storyboard map
    
    //MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad() // Do any additional setup after loading the view, typically from a nib.
        
        self.fetchBikeParkingData() // Makes network call -> Gets data from Seattle
        
        mapView.resetMapToViewEntireSeattle() // Sets map to view entire map
        mapView.drawDirectionRouteOnMap()
    }
    
    //MARK: Helper Methods
    func fetchBikeParkingData() {
        
        let service = WebService { (returnedJSON, errorMessage) -> Void in
            
            // convert returned json into modelparkingspotbike
            // next here!
            
//            let annotationTest = ParkingBikeSpotModel(title: "Test", subTitle: "Subtitle", coordinate: CLLocationCoordinate2DMake(47.5274, -122.3153))
            
            if let arrayOfModels = returnedJSON as? [ParkingBikeSpotModel] {
                for annotationTest in arrayOfModels {
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.mapView.addAnnotation(annotationTest)
                    })
                }
            }

            
            print(returnedJSON)
        }
        
        // Service layer calls HTTP request
        service.GET(NSURL(string: "https://data.seattle.gov/resource/fxh3-tqdm.json")!)
    }
}

