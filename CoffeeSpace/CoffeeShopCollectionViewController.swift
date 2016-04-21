//
//  CoffeeBrandsCollectionViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/16/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CoffeeShopCollectionViewController: PFQueryCollectionViewController, UISearchBarDelegate, {
    
    var shopId: String? = ""
    
    @IBOutlet weak var brandsCell: AvailableCoffeeCellCollectionViewCell!
    @IBOutlet var CollectionView: UICollectionView!
    
    var selectedCoffee = [PFObject]()
    var brandId: String = ""
    
    var searchText: String? = nil
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func queryForCollection() -> PFQuery {
        var query = PFQuery(className: "ShopLinkBrand")
        
        query.cachePolicy = .NetworkElseCache
        query.whereKey("shopId", equalTo: shopId!)
        
        query.getFirstObjectInBackgroundWithBlock { (shopbrand, error) -> Void in
            query = PFQuery(className: "coffeeBrand")
            
            let brandlist = shopbrand!["brandId"] as! [String]
            
            query.whereKey("_id", containedIn: brandlist)
            
            query.findObjectsInBackgroundWithBlock({ (brands, error) -> Void in
                print(brands)
            })
        }
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
}