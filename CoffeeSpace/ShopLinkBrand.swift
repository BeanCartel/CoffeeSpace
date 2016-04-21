//
//  ShopLinkBrand.swift
//  CoffeeSpace
//
//  Created by Luis Liz on 4/19/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse

class ShopLinkBrand: NSObject {
    
    var shopId: String?
    var brandIds: [String]?
    
    //constructor needs some work, specially with the image which I dont know how to get just yet, more on that when we need to display the data
    init(dictionary: NSDictionary){
        self.brandIds = (dictionary["brandIds"] as? [String]?)!
        self.shopId = dictionary["shopId"] as? String
    }
    
    class func postShopBrandLink(shopId: String?, brandId: [String]?, withCompletion completion: PFBooleanResultBlock?) {
        let ShopLinkBrand = PFObject(className: "ShopLinkBrand")
        let ShopLinkBrandQ = PFQuery(className: "ShopLinkBrand")
        
        ShopLinkBrand["shopId"] = shopId
        ShopLinkBrand["brandId"] = brandId
        
        ShopLinkBrandQ.whereKey("shopId", equalTo: shopId!)
        
        var brandid = brandId
        
        ShopLinkBrandQ.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            if(result?.count==0) {
                ShopLinkBrand.saveInBackgroundWithBlock(completion)
            } else {
                //update with new brandids
                let ids = result![0]["brandId"] as! [String]?
                //Repeating records
                //                if(ids!.count>0) {
//                    brandid! += ids!
//                    ShopLinkBrand["brandId"] = brandid
//                }
//                ShopLinkBrand.saveInBackgroundWithBlock(completion)
            }
        }
    }
    
    //Fetch the list of brands ids returns a dictionary with all the brands
    class func getBrandsForShops(shopId: String? withCompletion completion: PFBooleanResultBlock?) -> [String]? {
        var brands: [String]? = []
        
        let ShopBrandsTable = PFQuery(className: "ShopLinkBrand")
        
        ShopBrandsTable.whereKey("shopId", equalTo: shopId!)
        
        ShopBrandsTable.getFirstObjectInBackgroundWithBlock({ (result, error) -> Void in
            //gives me a list of results 
            brands += getBrandsInfo(results["brandId"])
        })
        
        
        return brands
    }
    
    //Gets list of brands information using brand ids
    class func getBrandsInfo(brandIds: [String]?)  {
        let ShopBrandsTable = PFQuery(className: "coffeeBrand")
        
        ShopBrandsTable.whereKey("_id", containedIn: brandIds)
        
        ShopBrandsTable.getFirstObjectInBackgroundWithBlock({ (result, error) -> Void in
            //gives me a list of all info with cooffeebrands
            getBrandsInfo(results)
        })
    }
}
