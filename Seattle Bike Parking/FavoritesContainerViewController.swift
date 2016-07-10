//
//  FavoritesContainerViewController.swift
//  Seattle Bike Parking
//
//  Created by Alex Cevallos on 6/19/16.
//  Copyright © 2016 Alex Cevallos. All rights reserved.
//

import UIKit

class FavoritesContainerViewController: UIViewController {
    
    var favoritesListViewController: FavoritesListViewController? // Holds delegate, calls delegate
    var favoritesMapViewController: FavoritesMapViewController? // Delegate implementation

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Favorites"
    }

    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "favoritesListViewControllerSegue" {
            
            guard let _ = sender as? FavoritesMapViewController else {
                
                return false
            }
            
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "favoritesMapViewControllerSegue" {
            
            if let favoritesListViewControllerUnwrapped = segue.destinationViewController as? FavoritesMapViewController {
                
                self.performSegueWithIdentifier("favoritesListViewControllerSegue", sender: favoritesListViewControllerUnwrapped)
                
            }
        }
        
        if segue.identifier == "favoritesListViewControllerSegue" {
            
            if let favoritesListViewControllerUnwrapped = segue.destinationViewController as? FavoritesListViewController {
                if let favoritesMapViewControllerUnwrapped = sender as? FavoritesMapViewController {
                    
                    favoritesListViewControllerUnwrapped.favoritesListToMapProtocol = favoritesMapViewControllerUnwrapped
                }
                
            }
        }
    }

}
