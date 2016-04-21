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
    var filteredShop: [ShopsWithYelp]!
    
    var searchText: String? = nil
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 150
        
        ShopsWithYelp.searchWithTerm("Coffee", completion: { (businesses: [ShopsWithYelp]!, error: NSError!) -> Void in
            self.shopsWithYelp = businesses
            self.filteredShop = businesses
            self.tableview.reloadData()
        })
        
        searchBar.delegate = self
        
        let barButton = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Done, target: self, action: "SignOut")
        self.navigationItem.rightBarButtonItem = barButton
        //let barButton = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Done, target: self, action: #selector(CoffeeShopsWithYelpViewController.SignOut))
        //self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.titleView = searchBar
    }
    
    func SignOut() {
        PFUser.logOut()
        let loginVC: UIViewController? = (self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController"))! as UIViewController
        
        self.presentViewController(loginVC!, animated: true, completion: nil)
    }
    
    //Search
    func search(searchText: String? = nil) {
        self.searchText = searchText
        
        if(!(self.searchText == nil)) {
            print("we have someting.")
            
            self.filteredShop = self.shopsWithYelp.filter({ (dataString: ShopsWithYelp) -> Bool in
                let name = dataString.name! as String
                
                if(!((name.rangeOfString(searchText!, options: .CaseInsensitiveSearch)) == nil)) {
                    return true
                } else {
                    return false
                }
            })
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
        self.tableview.reloadData()
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shopsWithYelp?.count > 0 {
            return (filteredShop?.count)!
        } else {
            return 0
        }
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier("CoffeeShopsCell", forIndexPath: indexPath) as! CoffeeShopsCell
        
        cell.shop = self.filteredShop[indexPath.row]
        
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
