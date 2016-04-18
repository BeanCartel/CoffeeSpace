//
//  ShopsWithYelp.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 4/7/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit

class ShopsWithYelp: NSObject {
    let name: String?
    
    let address: String?
    let imageURL: NSURL?
    let categories: String?
    let distance: String?
    let ratingImageURL: NSURL?
    let reviewCount: NSNumber?
    
    init(dictionary: NSDictionary) {
        
        
        name = dictionary["name"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = NSURL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joinWithSeparator(", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = NSURL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    class func Shops(array array: [NSDictionary]) -> [ShopsWithYelp] {
        var shops = [ShopsWithYelp]()
        for dictionary in array {
            let shop = ShopsWithYelp(dictionary: dictionary)
            shops.append(shop)
        }
        return shops
        
    }
    
    class func searchWithTerm(term: String, completion: ([ShopsWithYelp]!, NSError!) -> Void) {
        Yelp_Client.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
   
/**

     //func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: ([ShopsWithYelp]!, NSError!) -> Void) -> Void {
        //Yelp_Client.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, completion: completion)
    //}
 **/
}
