//
//  WebService.swift
//  Seattle Bike Park
//
//  Created by Alex Cevallos on 11/5/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import Foundation
import MapKit

class WebService: ProxyProtocol {
    
    // MARK: TypeAliases
    typealias CompletitionHandler = (returnedJSON: AnyObject?, errorMessage: String?) -> Void
    
    // MARK: Member Variables
    var urlSessionTask: NSURLSessionTask? // The task (actual action)
    
    var urlSession: NSURLSession  // The session of the data transfer
    
    var sessionConfiguration: NSURLSessionConfiguration   // Settings of the session
    
    let completitionHandler: CompletitionHandler? // Lets us know when data is returned
    
    // MARK: Initializers
    init(completition: CompletitionHandler?) {
        
        // Sets up session
        self.sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.sessionConfiguration.HTTPAdditionalHeaders = ["X-App-Token" : APIKeys.SeattleAPIToken.rawValue] // Our API key is the value
        self.urlSession = NSURLSession(configuration: self.sessionConfiguration)
        
        // We want our completition handler to be used by our WebService class
        self.completitionHandler = completition
    }
    
    // MARK: HTTP Methods
    func GET(urlToGet: NSURL) {
        
        self.urlSessionTask = self.urlSession.dataTaskWithURL(urlToGet, completionHandler: { (data, response, error) -> Void in
            
            self.methodHelper_parseResponse(data, response: response, error: error)
        })
        
        self.urlSessionTask?.resume()
    }
    
    // MARK: Helper Methods - Parsing
    func methodHelper_parseResponse(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void {
            
        var resultingJSON: AnyObject?
        var resultingErrorMessage: String?
        
        if let _ =  error { // Error establishing a connection
            
            resultingErrorMessage = self.methodHelper_parseError(WebServiceConstants_Errors.GenericError)
            
        } else {
            
            // Check: Do we have an HTTP Response?
            if let _ = response as? NSHTTPURLResponse {
                
                // Check: Do we have data returned from the API call ?
                if let dataReturned = data {
                    
                    do { // Try: JSON parsing
                        
                        let convertedJSON = try NSJSONSerialization.JSONObjectWithData(dataReturned, options: [])
                        
                        do {  // We don't want this JSON if there is an error..
                          //  print(convertedJSON)
                            resultingJSON = try self.methodHelper_isValidJSON(convertedJSON)
                                
                           // resultingJSON = self.methodHelper_parsesJSON(returnJSON)
                               // print(resultingJSON)
                            
                        } catch WebServiceConstants_Errors.InvalidJSON {
                            
                            self.methodHelper_parseError(WebServiceConstants_Errors.InvalidJSON)
                        }
                        
                    } catch { // Catch: Was there an error in NSJSONSerialization/ HTTP Status code ?
                        
                        // Regardless, we fetch the correct error message
                        resultingErrorMessage = self.methodHelper_parseError(WebServiceConstants_Errors.GenericError)
                    }
                }
            }
        }
        
        // Let our class completition handler know we are good !
        if let completionHandler = self.completitionHandler {
            completionHandler(returnedJSON: resultingJSON, errorMessage: resultingErrorMessage)
        }
    }
    
    func methodHelper_parseError(error: WebServiceConstants_Errors) -> String { // Will handle errors, for now: basic return
        
        return WebServiceConstants_ErrorMessages.DefaultErrorMessage.rawValue
    }
    
    // MARK: Helper Methods - Validity
    func methodHelper_parsesJSON(returnedJSONToParse: Array<NSDictionary>) -> [ParkingBikeSpotModel] {
        
        // Removes entries without latitude or longitude
        let arrayOfDictionariesFiltered = returnedJSONToParse.filter { (individualDictionaryOfParkingSpot) -> Bool in
            
            if let _ = individualDictionaryOfParkingSpot["latitude"] as? Double,
            let _  = individualDictionaryOfParkingSpot["longitude"] as? Double {
                
                return false
            }
            
            return true
        }
        
         return arrayOfDictionariesFiltered.map({ (individualDictionaryOfParkingSpot) -> ParkingBikeSpotModel in
            
                var parkingSpotTitle = "Unknown spots available"
                let parkingSpotSubtitle = ""
            
                // Returns back number of spots available
                if let parkingSpotTitleUnwrapped = individualDictionaryOfParkingSpot["rack_capac"] {
                    
                    parkingSpotTitle = "\(parkingSpotTitleUnwrapped) spots available"
                }
            
            
                // Forcefully unwrapping, since already filtered out non lat/long Doubles
                return ParkingBikeSpotModel(title: parkingSpotTitle, subTitle: parkingSpotSubtitle, coordinate: CLLocationCoordinate2DMake(
                    Double(individualDictionaryOfParkingSpot["latitude"] as! String)!,
                    Double(individualDictionaryOfParkingSpot["longitude"] as! String)!))
            })
        
        
    }
    
    
    func methodHelper_isValidJSON(json: AnyObject?) throws -> [AnyObject]  { // Its fine if it is Dictionary or array
        print(json)
        if let jsonConfirmedArray = json as? Array<NSDictionary> {
            
            let arrayOfModels = self.methodHelper_parsesJSON(jsonConfirmedArray)
            
            print(arrayOfModels)
            return arrayOfModels
        }
        
        throw WebServiceConstants_Errors.InvalidJSON
    }
}


