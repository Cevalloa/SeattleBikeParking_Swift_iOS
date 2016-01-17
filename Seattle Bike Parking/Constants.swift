//
//  Constants.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 11/15/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import Foundation

// MARK: API Keys
enum APIKeys: String {
    case SeattleAPIToken = ""
}

// MARK: MapKit Constants
enum MapKitConstants: Double {
    
    case SeattleCenter_latitude = 47.6274899
    case SeattleCenter_longitude = -122.3322241
    case regionRadius = 10000
}

// MARK: WebService Constants
enum WebServiceConstants_ErrorMessages: String {
    
    case DefaultErrorMessage = "There was a problem connecting.. "
}

enum WebServiceConstants_Errors: ErrorType {
    
    case GenericError
    case InvalidJSON
}



