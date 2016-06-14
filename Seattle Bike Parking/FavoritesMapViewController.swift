//
//  FavoritesMapViewController.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 6/13/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import UIKit
import MapKit

class FavoritesMapViewController: UIViewController {

    @IBOutlet weak var mapOfFavoriteBikes: MapOfFavoriteBikes!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapOfFavoriteBikes.resetFavoritesMapToViewEntireSeattle()
    }

}
