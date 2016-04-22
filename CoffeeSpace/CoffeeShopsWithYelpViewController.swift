//
//  CoffeeShopsWithYelpViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 4/16/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import AFNetworking
import Parse
import MaterialKit
import Spring
import TextFieldEffects


class CoffeeShopsWithYelpViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var shopsButton: UIButton!
    
    @IBOutlet weak var searchtextField: KaedeTextField!
    @IBOutlet weak var filterView: SpringView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var brandsButton: UIButton!

    
    var shopsWithYelp: [ShopsWithYelp]!
    
    var searchText: String? = nil
    //var searchBar = UISearchBar()
    var resultSearchController = UISearchController()
    
    var filtersOut: Bool?
    
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
        //self.navigationItem.titleView = searchBar
        
        let barButton = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Done, target: self, action: "signoutButton" )
        self.navigationItem.rightBarButtonItem = barButton
        
        filterView.alpha = 0
        filtersOut = false
        

    }
    
    func signoutButton() {
        
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
    
    //After Filters Button is pressed
    @IBAction func filtersButton(filterButton: UIButton) {
        
        if (filtersOut == false) {
            filterView.center = CGPointMake(self.tableview.frame.width/2, self.tableview.frame.height/2)
            UIView.animateWithDuration(0.5, animations: {
                self.filterView.alpha = 1
                
            })
            
            self.filterView.animation = "squeezeDown"
            self.filterView.animate()
            filtersOut = true
        } else {
            filterView.alpha = 0
            filtersOut = false
        }
        
        
        
        
        
        
        
    }
    
    
    @IBAction func searchtopButton(sender: MKButton) {
        UIView.animateWithDuration(0.5, animations: {
            sender.alpha = 0
        })
        
        
        
        
    }
    
    
    //Changes value of UISearchBar to updtae search results
    @IBAction func searchTextFieldValueChanged(sender: AnyObject) {
        let searchtext = sender.text
        searchBar.text = searchtext
    }
    
    //Filters View 
    
    @IBAction func brandsButtonPressed(sender: UIButton) {
        
        brandsButton.setBackgroundImage(UIImage(named: "botonfiltropressed"), forState: UIControlState.Normal)
        shopsButton.setBackgroundImage(UIImage(named: "botonfiltronormal"), forState: UIControlState.Normal)
    }
    
    @IBAction func shopsButtonPressed(sender: UIButton) {
        brandsButton.setBackgroundImage(UIImage(named: "botonfiltronormal"), forState: UIControlState.Normal)
        shopsButton.setBackgroundImage(UIImage(named: "botonfiltropressed"), forState: UIControlState.Normal)
    }
    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        let slidervalue = sender.value
        let distance = String(format: "%d", slidervalue)
        distanceLabel.text = distance
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
