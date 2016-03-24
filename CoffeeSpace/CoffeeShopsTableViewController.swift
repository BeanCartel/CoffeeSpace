//
//  CoffeeBradsTableViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/13/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import ParseUI
import Parse

//Totally Confused the class names, this is the CoffeeShops tableview, will change eventually
class CoffeeShopsTableViewController: PFQueryTableViewController {
    
    @IBOutlet var tableview: UITableView!
   
    var shopName: String! = ""
    var shopLocation: String! = ""
    var shopDescription: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func queryForTable() -> PFQuery
    {
        let query = PFQuery(className: "coffeeShop")
        
        query.cachePolicy = .CacheThenNetwork
        
        query.orderByDescending("createdAt")
        self.paginationEnabled = false
        self.objectsPerPage = 25
        return query

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell?
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CoffeeShopsCell", forIndexPath: indexPath) as! CoffeeShopsCell
        
        print(object!)
        
        cell.coffeeShopName?.text = object?.objectForKey("shopName") as? String
        cell.locationLabel?.text = object?.objectForKey("location") as? String
        cell.descriptionLabel?.text = object?.objectForKey("description") as? String
        
        object!["shopPic"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
            if error == nil {
                let image = UIImage(data: imageData!)
                cell.CoffeeShopImageView.setBackgroundImage(image, forState: UIControlState.Normal)
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((self.objects?.count) != nil) {
            print(self.objects?.count)
            return (self.objects?.count)!
        }else {
            return 0
        }
       
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let object = objectAtIndexPath(indexPath)
        
        self.shopName = object?.objectForKey("shopName") as? String
        self.shopLocation = object?.objectForKey("location") as? String
        self.shopDescription = object?.objectForKey("description") as? String
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "singleCoffeeShopViewController" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPathForCell(cell) {
                let singleCoffeeShopController = segue.destinationViewController as! singleCoffeeShopViewController
                
                singleCoffeeShopController.shopDescription = "\(self.shopDescription)"
                singleCoffeeShopController.shopName = "\(self.shopName)"
                singleCoffeeShopController.shopLocation = "\(self.shopLocation)"
                
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }
}
