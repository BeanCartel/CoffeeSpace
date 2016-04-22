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

class CoffeeShopCollectionViewController: PFQueryCollectionViewController, UISearchBarDelegate {
    
    var shopId: String? = ""
    var shopReference: PFObject?
    var brandId: String?
    @IBOutlet var brandsCollectionView: UICollectionView!
    
    var searchText: String? = nil
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    override func queryForCollection() -> PFQuery {
        
        let query = PFQuery(className: "coffeeBrand")
        
        if(brandId != nil){
        query.whereKey("_id", equalTo: brandId!)
        }
        
            return query
      
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.objects.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFCollectionViewCell? {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AvailableCoffeeCellCollectionViewCell", forIndexPath: indexPath) as! AvailableCoffeeCellCollectionViewCell
        
        
        cell.BrandNameLabel.text = object?.objectForKey("brandTitle") as? String
        object!["brandImage"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
            if error == nil {
                let image = UIImage(data: imageData!)
                cell.BrandImageView.image = image
            }
        }
        return cell
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
}