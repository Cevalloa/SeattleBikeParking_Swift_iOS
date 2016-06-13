//
//  FavoritesTableViewController.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 6/12/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    // Contains list of favorites
    var arrayOfFavoriteBikeSpots: [ParkingBikeSpotModel]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Converts NSUserDefaults favorites array from NSData into an array of BikeSpotModel objects
        methodConvertNSUserDefaultArrayIntoUsableBikeSpotModelArray()
    }
    
    //MARK: - Tableview Data Source Methods
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell = self.tableView.dequeueReusableCellWithIdentifier("favoritesCell", forIndexPath: indexPath) as! FavoritesTableViewCell
        
        if let arrayOfFavoriteBikeSpotsUnwrapped = arrayOfFavoriteBikeSpots {
            
            tableViewCell.methodSetUpCell(arrayOfFavoriteBikeSpotsUnwrapped[indexPath.row])
        } else {
            
            tableViewCell.labelTitleForFavoritesCell.text = "Hello"

        }
        
        return tableViewCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let arrayOfFavoriteBikeSpotsUnwrapped = arrayOfFavoriteBikeSpots {
            
            return arrayOfFavoriteBikeSpotsUnwrapped.count
        }
        return 0
    }
    
    //MARK: - NSUserDefaults Conversion Methods
    func methodConvertNSUserDefaultArrayIntoUsableBikeSpotModelArray() {
        
        // Finds array of NSData (converted from bike spot model objects)
        if let arrayOfNSDataSpotModelsUnwrapped = NSUserDefaults.standardUserDefaults().arrayForKey("arrayOfFavoriteBikeSpots") as? [NSData] {
            
            // Converted NSUserDefault array elements will be placed here
            var arrayOfFavoriteBikeSpotsConvertedFromUserDefaults: [ParkingBikeSpotModel] = []
            
            // Iterate through each NSData element
            for bikeSpotModelStillInDataForm in arrayOfNSDataSpotModelsUnwrapped {
                
                // Convert each NSData element into BikeSpotModel
                let unarc = NSKeyedUnarchiver(forReadingWithData: bikeSpotModelStillInDataForm)
                unarc.setClass(ParkingBikeSpotModel.self, forClassName: "ParkingBikeSpotModel")
                if let bikeSpotModelUnwrapped = unarc.decodeObjectForKey("root") as? ParkingBikeSpotModel {
                    
                    // Assign to this method's local variable
                    arrayOfFavoriteBikeSpotsConvertedFromUserDefaults.append(bikeSpotModelUnwrapped)
                }
            }
            
            // Assign our local array of Spot models into our global property in use by our table view
            arrayOfFavoriteBikeSpots = arrayOfFavoriteBikeSpotsConvertedFromUserDefaults
            self.tableView.reloadData()
        }
    }
}

// Table View Cell used for favorites table view
class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitleForFavoritesCell: UILabel!
    
    func methodSetUpCell(parkingBikeSpotModel: ParkingBikeSpotModel) {
        self.labelTitleForFavoritesCell.text = parkingBikeSpotModel.title
    }
    
    func methodSetUpCellSomethingHasGoneWrong() {
        self.labelTitleForFavoritesCell.text = ""
    }
    
}