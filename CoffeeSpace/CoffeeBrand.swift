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
    

    var brandTitle: String?
    var brandDescription: String?
    var rating: Double?
    var brand_profile_picture: PFFile?
    var location: String?
    //var fcPage = NSURL?
    
    //constructor needs some work, specially with the image which I dont know how to get just yet, more on that when we need to display the data
    init(dictionary: NSDictionary){
        self.brandTitle = dictionary["brandTitle"] as? String
        self.brandDescription = dictionary["description"] as? String
        self.location = dictionary["location"] as? String
        self.rating = dictionary["rating"] as? Double
        self.brand_profile_picture = dictionary["brandImage"] as? PFFile
        //self.fcPage = dictionary[""]
    }

    class func postBrandPage(image: UIImage?, title: String?,  description: String?, location: String?, fbURL: NSURL?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let coffeeBrand = PFObject(className: "coffeeBrand")
        
        // Add relevant fields to the object
        coffeeBrand["brandTitle"] = title
        coffeeBrand["brandImage"] = GlobalFuncs.getPFFileFromImage(image) // PFFile column type
        coffeeBrand["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        coffeeBrand["description"] = description
        coffeeBrand["location"] = location
        coffeeBrand["rating"] = 0
        coffeeBrand["commentsCount"] = 0
        print("success")
        
        coffeeBrand.saveInBackgroundWithBlock(completion)

       
    }
    
    func queryBrands(completion: (brands: [PFObject]?, error: NSError?)-> Void){
        let query = PFQuery(className: "coffeeBrand")
        query.orderByAscending("brandTitle")
        
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (brands: [PFObject]?, error: NSError?) -> Void in
            if let brands = brands {
                completion(brands: brands, error: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
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
