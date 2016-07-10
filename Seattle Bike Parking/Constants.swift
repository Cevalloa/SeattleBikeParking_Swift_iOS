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
    
    // Used for main map with bike spots
    case SeattleCenter_latitude = 47.6274899
    case SeattleCenter_longitude = -122.3322241
    
    // Used for small map with favorites
    case SeattleCenterFavorites_latitude = 47.6090899
    
    case regionRadius = 10000
}

// MARK: Color Constants
struct ColorConstants {
    
    // Navigation bar color
    let navigationBarColor = UIColor(red: 38/255, green: 41/255, blue: 46/255, alpha: 1)
    
    // Unselected tab bar color
    let tabBarUnselectedColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
    
    // Selected tab bar color
    let tabBarSelectedColor = UIColor.whiteColor()
    
    // Favorites main text color
    let favoritesMainTextColor = UIColor(red:66/255, green:204/255, blue:85/255, alpha:1.0)
    
    // Background color for favorites cell
    let backgroundCellColor = UIColor(red: 42/255, green: 45/255, blue: 50/255, alpha: 1.0)
}

// MARK: WebService Constants
enum WebServiceConstants_ErrorMessages: String {
    
    case DefaultErrorMessage = "There was a problem connecting.. "
}

enum WebServiceConstants_Errors: ErrorType {
    
    case GenericError
    case InvalidJSON
}



