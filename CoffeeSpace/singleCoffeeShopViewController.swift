//
//  singleCoffeeShopViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/10/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Cosmos

class singleCoffeeShopViewController: UIViewController {
    
    var shopName: String! = ""
    var shopId: String! = "" 
    var shopLocation: String! = ""
    var shopDescription: String! = ""
    var avgRating: Double! = 3.7
    var currentRating: Double! = 0
    var shopObject: PFObject?
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var locarionLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopNameLabel.text = "\(shopName)"
        descriptionLabel.text = "\(shopDescription)"
        
        //Settings for stars
        ratingView.settings.fillMode = .Half
        ratingView.settings.starSize = 30
        ratingView.settings.starMargin = 5
        ratingView.settings.filledColor = UIColor.grayColor()
        ratingView.settings.emptyBorderColor = UIColor.blackColor()
        ratingView.settings.filledBorderColor = UIColor.blackColor()
        
        ratingView.rating = avgRating
        ratingView.text = "\(avgRating)"
        ratingView.didTouchCosmos = { rating in
            self.ratingView.settings.filledColor = UIColor.orangeColor()
            self.ratingView.settings.emptyBorderColor = UIColor.orangeColor()
            self.ratingView.settings.filledBorderColor = UIColor.orangeColor()
        }
        ratingView.didFinishTouchingCosmos = {rating in self.currentRating = rating
            Rating.postRating(self.shopId, userId: PFUser.currentUser()?.objectId!, rating: rating, withCompletion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.  coffeeAvailableSegue
        
        if segue.identifier == "coffeeAvailableSegue" {
                let availableCoffeeShopsCollection = segue.destinationViewController as! CoffeeShopCollectionViewController
            availableCoffeeShopsCollection.shopObject = self.shopObject
            
    }

}
}