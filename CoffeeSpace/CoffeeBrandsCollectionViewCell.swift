//
//  CoffeeBrandsCollectionViewCell.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/16/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import ParseUI
import Parse


class CoffeeBrandsCollectionViewCell: PFCollectionViewCell {

    @IBOutlet weak var BrandImageView: UIImageView!
    @IBOutlet weak var BrandNameLabel: UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
