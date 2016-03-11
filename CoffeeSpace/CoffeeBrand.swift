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
        coffeeBrand["brandImage"] = getPFFileFromImage(image) // PFFile column type
        coffeeBrand["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        coffeeBrand["description"] = description
        coffeeBrand["location"] = location
        coffeeBrand["likesCount"] = 0
        coffeeBrand["commentsCount"] = 0
        print("success")
        
        coffeeBrand.saveInBackgroundWithBlock(completion)

       
    }
    
    class func postExtraImages(image: UIImage?, withCompletion completion: PFBooleanResultBlock?)
    {
        let coffeeBrand = PFObject(className: "coffeeBrand")
        coffeeBrand["extraImages"] = getPFFileFromImage(image)
        
        // Save object (following function will save the object in Parse asynchronously)
        coffeeBrand.saveInBackgroundWithBlock(completion)
    }
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}
