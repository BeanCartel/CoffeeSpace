//
//  SingleBrandViewController.swift
//  CoffeeSpace
//
//  Created by Luis Liz on 4/7/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse

class SingleBrandViewController: UIViewController {
    var brandId:String = ""
    var favCount: Int32 = 0
    
    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkCurUserFavorited()
        checkFavorites()
    }
    override func viewWillAppear(animated: Bool) {
      getBrands(brandId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFavBrand(sender: AnyObject) {
        Favorites.postBrandFav(brandId, userId: PFUser.currentUser()?.objectId, withCompletion: nil)
        self.favCount += 1
        self.favCountLabel.text = "\(self.favCount)"
    }
    
    func getBrands(id: String?) {
        let query = PFQuery(className: "coffeeBrand")

        query.whereKey("objectId", containsString: id)
        
        query.getFirstObjectInBackgroundWithBlock { (result, error) -> Void in
            self.brandLabel.text = result!["brandTitle"] as? String
            self.locationLabel.text = result!["location"] as? String
            self.descriptionLabel.text = result!["description"] as? String
        }
    }
    
    func checkCurUserFavorited() {
        let curUserId = PFUser.currentUser()?.objectId
        
        let query = PFQuery(className: "userFavorites")
        
        query.whereKey("brandId", containsString: self.brandId)
        
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil && count > 0 {
                query.whereKey("userId", containsString: curUserId)
                query.countObjectsInBackgroundWithBlock({ (exists, error) -> Void in
                    if(exists>0) {
                        self.favButton.enabled = false
                    } else {
                        print("naaaa")
                    }
                })
            }
        }
    }
    
    func checkFavorites() {
        let query = PFQuery(className: "userFavorites")
        query.whereKey("brandId", containsString: self.brandId)
        
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil && count > 0 {
                self.favCount = count
                self.favCountLabel.text = "\(count)"
            } else {
                self.favCountLabel.text = "0"
            }
        }
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
