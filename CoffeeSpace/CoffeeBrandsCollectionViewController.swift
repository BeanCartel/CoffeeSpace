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


class CoffeeBrandsCollectionViewController: PFQueryCollectionViewController, UISearchBarDelegate {
    
    @IBOutlet weak var brandCell: CoffeeBrandsCollectionViewCell!
    @IBOutlet var brandsCollectionView: UICollectionView!
    
    weak var mDelegate:MyProtocol?
    var comesFromAddCoffeeShop = false
    var selectedCoffee = [PFObject]()
    
    var searchText: String? = nil
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(comesFromAddCoffeeShop) {
//                let doneBtn : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CoffeeBrandsCollectionViewController.done(_:)))
//               self.navigationItem.rightBarButtonItem = doneBtn
//               self.brandsCollectionView.allowsMultipleSelection = true
        }
        
        let barButton = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Done, target: self, action: "SignOut")
        
        searchBar.delegate = self
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.titleView = searchBar
    }
    
    func SignOut() {
        PFUser.logOut()
        let loginVC: UIViewController? = (self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController"))! as UIViewController
        
        self.presentViewController(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func done(sender: AnyObject) {
        comesFromAddCoffeeShop = false
        brandsCollectionView.allowsMultipleSelection = false
        mDelegate?.sendArrayToPreviousVC(selectedCoffee)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func queryForCollection() -> PFQuery {
        let query = PFQuery(className: "coffeeBrand")
        
        query.cachePolicy = .NetworkElseCache
        
        query.orderByDescending("createdAt")
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
        if(searchText != nil){
            query.whereKey("brandTitle", containsString: searchText)
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
    
    //Collection View
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        
        if comesFromAddCoffeeShop {
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            
            if cell?.selected == true {
                cell?.backgroundColor = UIColor(red: 101, green: 66, blue: 56, alpha: 1)
                let selectedCoffeeBrand = objectAtIndexPath(indexPath)
                print(selectedCoffeeBrand?.objectId)
                selectedCoffee.append(selectedCoffeeBrand!)
            }
            else{
                cell?.backgroundColor = UIColor(red: 136, green: 96, blue: 82, alpha: 1)
            }
        }
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.objects.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFCollectionViewCell? {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CoffeeBrandsCollectionViewCell", forIndexPath: indexPath) as! CoffeeBrandsCollectionViewCell
       
       /** 
         if (cell.selected == true)
        {cell.backgroundColor = UIColor.orangeColor()}
        else{
            cell.backgroundColor = UIColor.clearColor()}
        **/
        
        cell.BrandNameLabel.text = object?.objectForKey("brandTitle") as? String
        object!["brandImage"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    cell.BrandImageView.image = image
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

protocol MyProtocol: class {
    func sendArrayToPreviousVC(myArray:[PFObject])
}
