//
//  BikeSpotParser.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 6/8/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit

class BikeSpotParser {

    // Takes in Bike Spot JSON, converts to models
    class func methodCreateArrayOfBikeSpotModels(returnedJSONToParse: Array<NSDictionary>) -> [ParkingBikeSpotModel] {
        
        // Removes entries without latitude or longitude
        let arrayOfDictionariesFiltered = methodRemoveAllNilValues(returnedJSONToParse)
        
        // After filtering out nil lat/long entries, we create bike spot models
        return methodParseIndividualDictionaryIntoBikeSpotModel(arrayOfDictionariesFiltered)
    }
    
    //MARK - Helper Methods
    class func methodRemoveAllNilValues(jsonToCheck: Array<NSDictionary>) -> Array<NSDictionary> {
        
        return jsonToCheck.filter { (individualDictionaryOfParkingSpot) -> Bool in
            
            if let _ = Double(individualDictionaryOfParkingSpot["latitude"] as! String),
                let _  = Double(individualDictionaryOfParkingSpot["longitude"] as! String) {
                
                return true
            }
            
            return false
        }
    }
    
    class func methodParseIndividualDictionaryIntoBikeSpotModel(arrayOfDictionariesFiltered: Array<NSDictionary>) -> [ParkingBikeSpotModel] {
        
        return arrayOfDictionariesFiltered.map({ (individualDictionaryOfParkingSpot) -> ParkingBikeSpotModel in
            
            var parkingSpotTitle = "Unknown spots available"
            var parkingSpotsAvailable = "N/A"
            let parkingSpotSubtitle = ""
            var parkingSpotAddress = ""
            
            // Returns back number of spots available
            if let parkingSpotTitleUnwrapped = individualDictionaryOfParkingSpot["rack_capac"] {
                
                parkingSpotTitle = "\(parkingSpotTitleUnwrapped) maximum capacity"
                parkingSpotsAvailable = "\(parkingSpotTitleUnwrapped)"
            }
            
            if let parkingSpotAddressUnwrapped = individualDictionaryOfParkingSpot["unitdesc"] as? String {
                
                //Capitalize only first element
                var parkingSpotAddressFinal = "\(String(parkingSpotAddressUnwrapped.characters.first!).uppercaseString)"
                
                var index: String.CharacterView.Index
                if let leftParenthesisIndexUnwrapped = parkingSpotAddressUnwrapped.characters.indexOf("(") {
                    
                    index = leftParenthesisIndexUnwrapped
                    

                } else {
                 
                    index = parkingSpotAddressUnwrapped.endIndex
                }
                
                parkingSpotAddressFinal += "\(parkingSpotAddressUnwrapped[parkingSpotAddressUnwrapped.startIndex.advancedBy(1)..<index].lowercaseString) "
                
                parkingSpotAddress = parkingSpotAddressFinal
            }
            
            // Forcefully unwrapping, since already filtered out non lat/long Doubles
            return ParkingBikeSpotModel(title: parkingSpotTitle, subTitle: parkingSpotSubtitle, spotsAvailable: parkingSpotsAvailable, address: parkingSpotAddress, coordinate: CLLocationCoordinate2DMake(
                Double(individualDictionaryOfParkingSpot["latitude"] as! String)!,
                Double(individualDictionaryOfParkingSpot["longitude"] as! String)!))
        })
    }
}








