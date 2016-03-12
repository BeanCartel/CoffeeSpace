//
//  CoffeeBrand.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/10/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse

class CoffeeBrand: NSObject {

    class func postBrandPage(image: UIImage?, title: String?,  description: String?, location: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let coffeeBrand = PFObject(className: "coffeeBrand")
        
        // Add relevant fields to the object
        coffeeBrand["brandTitle"] = title
        coffeeBrand["brandImage"] = GlobalFuncs.getPFFileFromImage(image) // PFFile column type
        coffeeBrand["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        coffeeBrand["description"] = description
        coffeeBrand["location"] = location
        coffeeBrand["likesCount"] = 0
        coffeeBrand["commentsCount"] = 0
        print("success")
        
        coffeeBrand.saveInBackgroundWithBlock(completion)

       
    }
    //This method is for the user to add more images to a coffeeBrand, no implementation yet
    class func postExtraImages(image: UIImage?, withCompletion completion: PFBooleanResultBlock?)
    {
        let coffeeBrand = PFObject(className: "coffeeBrand")
        
        coffeeBrand["extraImages"] = GlobalFuncs.getPFFileFromImage(image)
        
        // Save object (following function will save the object in Parse asynchronously)
        coffeeBrand.saveInBackgroundWithBlock(completion)
    }
}
