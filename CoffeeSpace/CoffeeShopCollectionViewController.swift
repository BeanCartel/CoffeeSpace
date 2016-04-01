//
//  CoffeeShopCollectionViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/31/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class CoffeeShopCollectionViewController: UICollectionViewController {

    @IBOutlet var collectionview: UICollectionView!
    
    var shopObject : PFObject?
    var coffeeBrands: [PFObject]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        coffeeBrands = shopObject?.valueForKey("availableCoffee") as? [PFObject]
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return coffeeBrands!.count
    }
    
   override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AvailableCoffeeCellCollectionViewCell", forIndexPath: indexPath) as! AvailableCoffeeCellCollectionViewCell
        print(shopObject?.valueForKey("shopName"))
        print(coffeeBrands![0].valueForKey("objectId") )
    
        for p in coffeeBrands!{
        let id = p.valueForKey("objectId") as? String
        //let query = PFQuery(className: "coffeeBrand")
        let brand = PFObject(outDataWithClassName: "coffeeBrand", objectId: id)
           
            do {
                try brand.fetchIfNeeded()
            } catch {
                print("Error")
            }
            print(brand.objectForKey("brandTitle"))
            cell.BrandNameLabel.text = brand.objectForKey("brandTitle") as? String
            brand["brandImage"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    cell.BrandImageView.image = image
                }
            }
        
        }
        return cell
        
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
