//
//  Favorites.swift
//  CoffeeSpace
//
//  Created by Luis Liz on 4/7/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse

class Favorites: NSObject {
    class func postBrandFav(brandId: String!, userId: String!, withCompletion completion: PFBooleanResultBlock?) {
        let favorite = PFObject(className: "userFavorites")
        
        favorite["brandId"] = brandId
        favorite["userId"] = userId
        
        favorite.saveInBackgroundWithBlock(completion)
        
        print("user \(userId) has favorited brand \(brandId)")
    }
    
    //Possible CoffeeshopFavorite
    class func postShopFav() {
        
    }
}
