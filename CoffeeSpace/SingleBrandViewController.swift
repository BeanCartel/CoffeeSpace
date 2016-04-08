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
    
    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkFavorited()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFavBrand(sender: AnyObject) {
        Favorites.postBrandFav(brandId, userId: PFUser.currentUser()?.objectId, withCompletion: nil)
    }
    
    func checkFavorited() {
        let query = PFQuery(className: "userFavorites")
        query.whereKey("brandId", containsString: self.brandId)
        
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil && count > 0 {
                print("There's a favorite")
            } else if(count>1) {
                print("there's a fav, but weird, there's more than one")
            } else {
                print("no favorite here")
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
