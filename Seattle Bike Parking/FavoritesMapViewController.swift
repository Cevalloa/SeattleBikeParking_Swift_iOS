//
//  FavoritesMapViewController.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 6/13/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import UIKit
import MapKit

class FavoritesMapViewController: UIViewController, FavoritesListToMapProtocol {

    @IBOutlet weak var mapOfFavoriteBikes: MapOfFavoriteBikes!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapOfFavoriteBikes.resetFavoritesMapToViewEntireSeattle()
    }
    
    func favoriteCellPressedTimeToUpdateMapLocation(parkingBikeSpotModel: ParkingBikeSpotModel) {
        
        
        if mapOfFavoriteBikes.annotations.count > 0 {
            mapOfFavoriteBikes.removeAnnotations(mapOfFavoriteBikes.annotations)
        }
        mapOfFavoriteBikes.centerMapOnFavoritesLocation(parkingBikeSpotModel.coordinate)
        mapOfFavoriteBikes.addAnnotation(parkingBikeSpotModel)
    }

}

protocol FavoritesListToMapProtocol {
    func favoriteCellPressedTimeToUpdateMapLocation(parkingBikeSpotModel: ParkingBikeSpotModel)
}
