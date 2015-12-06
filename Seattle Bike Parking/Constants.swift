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

// MARK: WebService Constants
enum WebServiceConstants_ErrorMessages: String {
    
    case DefaultErrorMessage = "There was a problem connecting.. "
}

enum WebServiceConstants_Errors: ErrorType {
    
    case GenericError
    case InvalidJSON
}



