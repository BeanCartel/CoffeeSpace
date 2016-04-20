//
//  CoffeeShopsWithYelpViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 4/16/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import AFNetworking
import Parse

class CoffeeShopsWithYelpViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableview: UITableView!

    
    var shopsWithYelp: [ShopsWithYelp]!
    
    var searchText: String? = nil
    var searchBar = UISearchBar()
    var resultSearchController = UISearchController()
    
    override func viewWillAppear(animated: Bool) {
        ShopsWithYelp.searchWithTerm("Coffee", completion: { (businesses: [ShopsWithYelp]!, error: NSError!) -> Void in
            self.shopsWithYelp = businesses
            self.tableview.reloadData()
        })
        
    }
    
    //Search
    func search(searchText: String? = nil) {
        self.searchText = searchText
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 150
        
        searchBar.delegate = self
        //let barButton = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Done, target: self, action: #selector(CoffeeShopsWithYelpViewController.SignOut))
        //self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.titleView = searchBar
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shopsWithYelp?.count > 0 {
            return (shopsWithYelp?.count)!
        }else {
            
            return 0
        }
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier("CoffeeShopsCell", forIndexPath: indexPath) as! CoffeeShopsCell
        
        cell.shop = self.shopsWithYelp[indexPath.row]
        
        
        return cell
        
    }
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
  
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "singleCoffeeShopViewController" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableview.indexPathForCell(cell) {
                let singleCoffeeShopController = segue.destinationViewController as! singleCoffeeShopViewController
                
                 let shop = self.shopsWithYelp[indexPath.row]
                
                singleCoffeeShopController.shop = shop
                print("Here it comes")
                let name = shop.name!
                print(name)
                
                
                tableview.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }


}
