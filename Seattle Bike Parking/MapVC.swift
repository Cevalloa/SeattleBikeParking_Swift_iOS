//
//  ViewController.swift
//  Seattle Bike Park
//
//  Created by Alex Cevallos on 11/5/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    //MARK: IBOutlet Properties
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let service = WebService { (returnedJSON, errorMessage) -> Void in
            
        }
        
        
        service.GET(NSURL(string: "https://data.seattle.gov/resource/fxh3-tqdm.json")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

