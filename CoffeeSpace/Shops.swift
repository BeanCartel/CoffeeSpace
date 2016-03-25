//
//  Shops.swift
//  CoffeeSpace
//
//  Created by Luis Liz on 3/11/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse

class Shops: NSObject {
//    var dictionary: NSDictionary?
//    
//    var title: String?
//    var description: String?
//    var rating: Int
//    var profile_picture: UIImage?
//    var coffees: NSDictionary?
//    
//    init(dictionary: NSDictionary) {
//        self.dictionary = dictionary
//
//        title = dictionary["title"]
//    
//    }
    
    class func postShop(name: String!, description: String!, shopImage: UIImage?, availableCoffee: [PFObject]?, facebook: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        let size = CGSizeMake(400, 400)
        let image = GlobalFuncs.resizeImg(shopImage!, newSize: size)
        
        let shop = PFObject(className: "coffeeShop")
        
        shop["shopName"] = name
        shop["description"] = description
        shop["rating"] = 0
        shop["shopPic"] = GlobalFuncs.getPFFileFromImage(image)
       // shop["coffees"] = coffees
        shop["facebookURL"] = facebook
        shop.addUniqueObjectsFromArray(availableCoffee!, forKey: "availableCoffee")
        print("we got a new shop!")
        
        shop.saveInBackgroundWithBlock(completion)
        
    }
}
