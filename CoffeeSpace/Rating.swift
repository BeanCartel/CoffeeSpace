//
//  Rating.swift
//  CoffeeSpace
//
//  Created by Luis Liz on 3/31/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse

class Rating: NSObject {
    class func postRating(shopId: String!, userId: String!, rating: Double!, withCompletion completion: PFBooleanResultBlock?) {
        let shopRating = PFObject(className: "shopRatings")
        //let shopRatingQuery = PFQuery(className: "shopRatings")
        
        shopRating["shopId"] = shopId
        shopRating["userId"] = userId
        shopRating["rating"] = rating
        print("we got a new rating on shop: \(shopId). The user: \(userId) gave it a \(rating)")
        
        /*shopRatingQuery.whereKey("shopId", equalTo: shopId)
        shopRatingQuery.whereKey("userId", equalTo: userId)
        
        do {
            try shopRatingQuery.findObjects()
        } catch _ {
            print("error")
        }*/
        
        shopRating.saveInBackgroundWithBlock(completion)
        
    }
}