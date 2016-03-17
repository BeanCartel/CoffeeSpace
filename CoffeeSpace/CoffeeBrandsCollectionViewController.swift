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


class CoffeeBrandsCollectionViewController: PFQueryCollectionViewController {
    @IBOutlet weak var brandCell: CoffeeBrandsCollectionViewCell!

    @IBOutlet var brandsCollectionView: UICollectionView!
    
    override func queryForCollection() -> PFQuery {
        let query = PFQuery(className: "coffeeBrand")
        
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
       
        cell.BrandNameLabel.text = object?.objectForKey("brandTitle") as? String
        object!["brandImage"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    cell.BrandImageView.image = image
                }
        }
        return cell
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.brandsCollectionView.backgroundColor = UIColor.brownColor()
        self.brandsCollectionView.alpha = 0.7
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
