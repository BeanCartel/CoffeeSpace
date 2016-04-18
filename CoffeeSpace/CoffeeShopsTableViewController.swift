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
   
    
    var businesses: [ShopsWithYelp]!
    var shopId: String! = ""
    var shopName: String! = ""
    var shopLocation: String! = ""
    var shopDescription: String! = ""
    
    var searchText: String? = nil
    var searchBar = UISearchBar()
    var resultSearchController = UISearchController()

    
    override func viewWillAppear(animated: Bool) {
        ShopsWithYelp.searchWithTerm("Coffee", completion: { (businesses: [ShopsWithYelp]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            print(self.businesses)
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let parameters = ["ll": "37.788022,-122.399797", "term": "coffee", "radius_filter": "3000", "sort": "0"]
    
       
    /**
        client.searchPlacesWithParameters(parameters, successSearch: { (data, response) -> Void in
            print(NSString(data: data as! NSData, encoding: NSUTF8StringEncoding))
            //let dictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData)! as? NSDictionary
            let sureData = data as! NSData
            let dictionaries = sureData.va
            print(dictionaries)
            
        }) { (error) -> Void in
            print(error)
        }
        
        ShopsWithYelp.searchWithTerm(parameters, completion:  { (businesses: [ShopsWithYelp]!, error: NSError!) in
            self.businesses = businesses
            print( businesses)
            print("In here, just hard to display")
        })
        **/
        searchBar.delegate = self
        let barButton = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Done, target: self, action: #selector(CoffeeShopsTableViewController.SignOut))
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.titleView = searchBar
    }
    
    func SignOut() {
        PFUser.logOut()
        let loginVC: UIViewController? = (self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController"))! as UIViewController
        
        self.presentViewController(loginVC!, animated: true, completion: nil)
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
    
    //Table Views
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("CoffeeShopsCell", forIndexPath: indexPath) as! CoffeeShopsCell
        
        cell.coffeeShopName?.text = object?.objectForKey("shopName") as? String
        cell.locationLabel?.text = object?.objectForKey("location") as? String
        cell.descriptionLabel?.text = object?.objectForKey("description") as? String
        
        object!["shopPic"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
            if error == nil {
                let image = UIImage(data: imageData!)
                cell.CoffeeShopImageView.setBackgroundImage(image, forState: UIControlState.Normal)
            }
        }
    
       print("index is "  )
        print(indexPath.row)
        if(self.businesses != nil &&  indexPath.row >= objects!.count){
         cell.shop = self.businesses[indexPath.row]
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((self.objects?.count) != nil) {
            var sumCount = (self.objects?.count)!
            if(self.businesses?.count != nil)
            {
                sumCount = sumCount + (self.businesses?.count)!
            }
            return sumCount
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
                
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }
}
