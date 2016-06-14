//
//  ParkingBikeSpotModel.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 1/16/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class ParkingBikeSpotModel: NSObject, MKAnnotation {
 
    var title: String?
    var subTitle: String?
    var spotsAvailable: String?
    var address: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subTitle: String?, spotsAvailable: String?, address: String?, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.subTitle = subTitle
        self.spotsAvailable = spotsAvailable
        self.address = address
        self.coordinate = coordinate
    }
    
    init(coder aDecoder: NSCoder) {
        
        self.title = aDecoder.decodeObjectForKey("title") as? String
        self.subTitle = aDecoder.decodeObjectForKey("subTitle") as? String
        self.spotsAvailable = aDecoder.decodeObjectForKey("spotsAvailable") as? String
        self.address = aDecoder.decodeObjectForKey("address") as? String
        let latitude = aDecoder.decodeDoubleForKey("kPinCoordinateLatitudeKey")
        let longitude = aDecoder.decodeDoubleForKey("kPinCoordinateLongitudeKey")
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    }

    func encodeWithCoder(aCoder: NSCoder!) {
        
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(subTitle, forKey: "subTitle")
        aCoder.encodeObject(spotsAvailable, forKey: "spotsAvailable")
        aCoder.encodeObject(address, forKey: "address")
        aCoder.encodeDouble(coordinate.latitude, forKey: "kPinCoordinateLatitudeKey")
        aCoder.encodeDouble(coordinate.longitude, forKey: "kPinCoordinateLongitudeKey")
    }
}

