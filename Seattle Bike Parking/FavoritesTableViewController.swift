//
//  FavoritesTableViewController.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 6/12/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewFavorites: UITableView!
    @IBOutlet weak var labelNoFavoritesAvailable: UILabel!
    
    // Contains list of favorites
    var arrayOfFavoriteBikeSpots: [ParkingBikeSpotModel]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Delegate and data source for favorite table view
        self.tableViewFavorites.delegate = self
        self.tableViewFavorites.dataSource = self
        
        // Converts NSUserDefaults favorites array from NSData into an array of BikeSpotModel objects
        methodConvertNSUserDefaultArrayIntoUsableBikeSpotModelArray()
    }
    
    //MARK: - Tableview Data Source Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell = tableViewFavorites.dequeueReusableCellWithIdentifier("favoritesCell", forIndexPath: indexPath) as! FavoritesTableViewCell
        
        if let arrayOfFavoriteBikeSpotsUnwrapped = arrayOfFavoriteBikeSpots {
            
            tableViewCell.methodSetUpCell(arrayOfFavoriteBikeSpotsUnwrapped[indexPath.row])
        } else {
            
            tableViewCell.methodSetUpCellSomethingHasGoneWrong()
        }
        
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let arrayOfFavoriteBikeSpotsUnwrapped = arrayOfFavoriteBikeSpots {
            
            return arrayOfFavoriteBikeSpotsUnwrapped.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
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
            labelNoFavoritesAvailable.hidden = true
            tableViewFavorites.hidden = false
            tableViewFavorites.reloadData()
        } else {
            
            self.tableViewFavorites.hidden = true
            labelNoFavoritesAvailable.hidden = false
            self.labelNoFavoritesAvailable.textColor = ColorConstants().favoritesMainTextColor
        }
    }
}

// Table View Cell used for favorites table view
class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitleForFavoritesCell: UILabel!
    @IBOutlet weak var labelNumberOfSpots: UILabel!
    @IBOutlet weak var labelSpots: UILabel!
    
    @IBOutlet weak var viewForRightContainer: UIView!
    func methodSetUpCell(parkingBikeSpotModel: ParkingBikeSpotModel) {
        self.labelTitleForFavoritesCell.text = parkingBikeSpotModel.address
        
        
        self.backgroundColor = UIColor.whiteColor()
        
        methodApplyTheme()
    }
    
    func methodSetUpCellSomethingHasGoneWrong() {
        self.labelTitleForFavoritesCell.text = ""
        
        methodApplyTheme()
    }
    
    func methodApplyTheme() {
        
        // Container to the right of table view cell
        viewForRightContainer.backgroundColor = ColorConstants().favoritesMainTextColor
        
        // Main title
        self.labelTitleForFavoritesCell.textColor = ColorConstants().favoritesMainTextColor
        
        // Labels inside container to the right
        self.labelNumberOfSpots.textColor = ColorConstants().tabBarSelectedColor
        self.labelSpots.textColor = ColorConstants().tabBarSelectedColor
    }
    
}