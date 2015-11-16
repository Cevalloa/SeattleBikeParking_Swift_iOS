//
//  MockTests.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 11/15/15.
//  Copyright © 2015 Alex Cevallos. All rights reserved.
//

import XCTest
@testable import Seattle_Bike_Parking

class WebServiceTests: XCTestCase {
    
    func testShouldFailGetRequest_Error() { // Test status code && network connection
        
        weak var expectationError = expectationWithDescription("testWebServiceGET_Error404")
        
        let webService = WebService { (returnedJSON, errorMessage) -> Void in
            
            XCTAssertNotNil(errorMessage, "We need an error")
            XCTAssertTrue(errorMessage == WebServiceConstants_ErrorMessages.DefaultErrorMessage.rawValue)
            
            if let expectationErrorUnwrapped = expectationError {
                
                expectationErrorUnwrapped.fulfill()
            }
        }
        
        let url = NSURL(string: "https://httpbin.org/status/404")
        webService.GET(url!)
        
        waitForExpectationsWithTimeout(6.0, handler: nil)
    }
    
    func testShouldFailGetRequest_ValidJSON() { // Test status code && network connection
        
        weak var expectationError = expectationWithDescription("testWebServiceGET_ValidJSON")
        
        let webService = WebService { (returnedJSON, errorMessage) -> Void in
            
            XCTAssertNil(errorMessage, "We don't need an error")
            XCTAssertNotNil(returnedJSON, "We should have received a response")
            
            if let expectationErrorUnwrapped = expectationError {
                
                expectationErrorUnwrapped.fulfill()
            }
        }
        
        let url = NSURL(string: "https://httpbin.org/get")
        webService.GET(url!)
        
        waitForExpectationsWithTimeout(6.0, handler: nil)
    }
    
    func testShouldFailGetRequest_InvalidJSON() { // Test status code && network connection
        
        weak var expectationError = expectationWithDescription("testWebServiceGET_InvalidJSON")
        
        let webService = WebService { (returnedJSON, errorMessage) -> Void in
            
            XCTAssertNotNil(errorMessage, "We need an error")
            XCTAssert(errorMessage == WebServiceConstants_ErrorMessages.DefaultErrorMessage.rawValue, "Received invalid JSON")
            
            if let expectationErrorUnwrapped = expectationError {
                
                expectationErrorUnwrapped.fulfill()
            }
        }
        
        let url = NSURL(string: "https://httpbin.org/xml")
        webService.GET(url!)
        
        waitForExpectationsWithTimeout(6.0, handler: nil)
    }
}
