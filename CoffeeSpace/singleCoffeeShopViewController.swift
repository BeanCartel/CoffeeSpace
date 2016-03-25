//
//  singleCoffeeShopViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/10/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class singleCoffeeShopViewController: UIViewController {
    
    var shopName: String! = ""
    var shopLocation: String! = ""
    var shopDescription: String! = ""
    
    
    
   
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    /**
    override func queryForCollection() -> PFQuery {
        let query = PFQuery(className: "coffeeShop")
        
        query.cachePolicy = .NetworkElseCache
        
        query.orderByDescending("createdAt")
        self.paginationEnabled = false
        self.objectsPerPage = 25
        return query
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.objects.count
    }
    
   override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFCollectionViewCell? {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CoffeeBrandsCollectionViewCell", forIndexPath: indexPath) as! CoffeeBrandsCollectionViewCell
        //let arr = object!["availableCoffee"]
        
        //cell.BrandNameLabel.text = object?.objectForKey("brandTitle") as? String
        object!["availableCoffee"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
            if error == nil {
                let image = UIImage(data: imageData!)
                cell.BrandImageView.image = image
            }
        }
        return cell}
    **/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopNameLabel.text = "\(shopName)"
        descriptionLabel.text = "\(shopDescription)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
