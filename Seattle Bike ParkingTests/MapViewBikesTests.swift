//
//  MapViewTests.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 1/12/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import XCTest
import MapKit
@testable import Seattle_Bike_Parking


class MapViewBikesTests: XCTestCase {
    
    var mainViewControllerThatContainsMap: MainViewController!

    
    // MARK: Unit Tests
    func testShouldSetMapToViewEntireSeattle() {  // Test: Ensures the mapView resets to center seattle
        
        mainViewControllerThatContainsMap.mapView.resetMapToViewEntireSeattle()
        
        // Opinion: Using force unwrapping in tests, would fail otherwise
        XCTAssertEqualWithAccuracy(mainViewControllerThatContainsMap.mapView.region.center.longitude, MapKitConstants.SeattleCenter_longitude.rawValue, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(mainViewControllerThatContainsMap.mapView.region.center.latitude, MapKitConstants.SeattleCenter_latitude.rawValue, accuracy: 0.1)
    }

    // MARK: XCTestCase Methods
    override func setUp() {
        super.setUp()
        
        self.setsUpMainViewControllerWithMap() // Loads the map view's logic we want to test
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Helper Methods
    func setsUpMainViewControllerWithMap() {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) // Load Storyboard
        let navigationController = storyboard.instantiateInitialViewController() as! UITabBarController // Loads TabBarController
        let testo = navigationController.viewControllers?.first as! UINavigationController // Loads NavigationController
        mainViewControllerThatContainsMap = testo.topViewController as! MainViewController // Loads Our created Main View Controller
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = mainViewControllerThatContainsMap // Sets our main view controller
    }
}

