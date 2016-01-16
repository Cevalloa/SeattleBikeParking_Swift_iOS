//
//  ViewController.swift
//  Seattle Bike Park
//
//  Created by Alex Cevallos on 11/5/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    //MARK: IBOutlet Properties
    @IBOutlet weak var mapView: MapViewBikes! // Custom mapView class set for storyboard map
    
    //MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad() // Do any additional setup after loading the view, typically from a nib.
        
        self.fetchBikeParkingData() // Makes network call -> Gets data from Seattle
        
        mapView.resetMapToViewEntireSeattle() // Sets map to view entire map

    }
    
    //MARK: Helper Methods
    func fetchBikeParkingData() {
        
        let service = WebService { (returnedJSON, errorMessage) -> Void in
            
        }
        
        service.GET(NSURL(string: "https://data.seattle.gov/resource/fxh3-tqdm.json")!)
    }
}

