//
//  RestaurantCell.swift
//  Yelp
//
//  Created by TriNgo on 3/17/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var distancesLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!

   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.restaurantImageView.layer.masksToBounds = true
        self.restaurantImageView.layer.cornerRadius = CGRectGetWidth(self.restaurantImageView.frame)/8
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
