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

class CoffeeShopsTableViewController: PFQueryTableViewController, UISearchBarDelegate {
    
    @IBOutlet var tableview: UITableView!
    
    var shopId: String! = ""
    var shopName: String! = ""
    var shopLocation: String! = ""
    var shopDescription: String! = ""
    
    var searchText: String? = nil
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let barButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Done, target: self, action: "cancelSearch")
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.titleView = searchBar
    }
    
    //Query
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "coffeeShop")
        
        query.cachePolicy = .CacheThenNetwork
        query.orderByDescending("createdAt")
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
        if(searchText != nil){
            query.whereKey("shopName", containsString: searchText)
        }
        return query
    }
    
    
    //Search
    func search(searchText: String? = nil) {
        self.searchText = searchText
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
        self.loadObjects()
    }
    
    func cancelSearch() {
        searchBar.resignFirstResponder()
    }
    
    //Table Views
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("CoffeeShopsCell", forIndexPath: indexPath) as! CoffeeShopsCell
        
        cell.coffeeShopName?.text = object?.objectForKey("shopName") as? String
        cell.locationLabel?.text = object?.objectForKey("location") as? String
        cell.descriptionLabel?.text = object?.objectForKey("description") as? String
        
        object?.objectForKey("shopPic")!.getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
            if error == nil {
                let image = UIImage(data: imageData!)
                cell.CoffeeShopImageView.setBackgroundImage(image, forState: UIControlState.Normal)
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((self.objects?.count) != nil) {
            return (self.objects?.count)!
        }else {
            return 0
        }
       
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let object = objectAtIndexPath(indexPath)
        
        self.shopName = object?.objectForKey("shopName") as? String
        self.shopId = object?.objectId!
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
                
                singleCoffeeShopController.shopObject = objectAtIndexPath(indexPath)
                
                singleCoffeeShopController.shopDescription = "\(self.shopDescription)"
                singleCoffeeShopController.shopName = "\(self.shopName)"
                //singleCoffeeShopController.shopId = "\(self.shopId)"
                singleCoffeeShopController.shopLocation = "\(self.shopLocation)"
                
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }
}
