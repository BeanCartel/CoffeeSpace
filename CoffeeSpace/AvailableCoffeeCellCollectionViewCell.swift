//
//  AvailableCoffeeCellCollectionViewCell.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 4/1/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit

class AvailableCoffeeCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var BrandImageView: UIImageView!
    
    @IBOutlet weak var BrandNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundView?.alpha = 0.5
        
    }
}
