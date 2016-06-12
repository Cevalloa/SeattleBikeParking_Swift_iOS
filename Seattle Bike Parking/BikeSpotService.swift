//
//  BikeSpotService.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 6/11/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import Foundation

class BikeSpotService {
    
    func methodGetRequestForBikeSpots(proxy: WebServiceProxy) {
        
        proxy.GET(NSURL(string: "https://data.seattle.gov/resource/fxh3-tqdm.json")!)
    }
}
