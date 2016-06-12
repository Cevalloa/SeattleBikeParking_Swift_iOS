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
        
        let proxy = WebServiceProxy { (returnedJSON, errorMessage) -> Void in
            
            let returnedJSONTwo = BikeSpotParser.methodCreateArrayOfBikeSpotModels(returnedJSON)
            
            // convert returned json into modelparkingspotbike
  //          if let arrayOfModels = returnedJSONTwo as? [ParkingBikeSpotModel] {
                for annotationTest in returnedJSONTwo {
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.mapView.addAnnotation(annotationTest)
                    })
                }
    //        }

            
            print(returnedJSON)
        }
        
        // Service layer calls HTTP request
        let bikeSpotService = BikeSpotService()
        bikeSpotService.methodGetRequestForBikeSpots(proxy)
     //   service.GET(NSURL(string: "https://data.seattle.gov/resource/fxh3-tqdm.json")!)
    }
}

