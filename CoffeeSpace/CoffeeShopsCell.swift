//
//  CoffeeBrandsCell.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/15/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CoffeeShopsCell: PFTableViewCell {

    @IBOutlet weak var CoffeeShopImageView: UIButton!
    @IBOutlet weak var coffeeShopName: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
     var someImage: UIImage?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var shop: ShopsWithYelp! {
        didSet {
            coffeeShopName.text = shop.name
            
            if(shop.imageURL != nil){
                
            CoffeeShopImageView.setBackgroundImageForState(UIControlState.Normal, withURL: shop.imageURL!)
                
            }
            locationLabel.text = shop.address
            //likesLabel.text = "\(shop.reviewCount!) Reviews"
            //ratingImageView.setImageWithURL(business.ratingImageURL!)
            //distanceLabel.text = business.distance
        }


}
}