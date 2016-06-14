//
//  Constants.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 11/15/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import Foundation
import UIKit

// MARK: API Keys
enum APIKeys: String {
    case SeattleAPIToken = "ebrYanNdBTTXHfiMphwR94q00"
}

// MARK: MapKit Constants
enum MapKitConstants: Double {
    
    case SeattleCenter_latitude = 47.6274899
    case SeattleCenter_longitude = -122.3322241
    case regionRadius = 10000
}

// MARK: Color Constants
struct ColorConstants {
    
    // Navigation bar color
    let navigationBarColor = UIColor(red: 10/255, green: 158/255, blue: 204/255, alpha: 1)
    
    // Unselected tab bar color
    let tabBarUnselectedColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
    
    // Selected tab bar color
    let tabBarSelectedColor = UIColor.whiteColor()
    
    // Favorites main text color
    let favoritesMainTextColor = UIColor(red: 6/255, green: 100/255, blue: 129/255, alpha: 1.0)
}

// MARK: WebService Constants
enum WebServiceConstants_ErrorMessages: String {
    
    case DefaultErrorMessage = "There was a problem connecting.. "
}

enum WebServiceConstants_Errors: ErrorType {
    
    case GenericError
    case InvalidJSON
}



