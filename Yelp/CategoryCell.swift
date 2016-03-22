//
//  CategoryCell.swift
//  Yelp
//
//  Created by TriNgo on 3/21/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol CategoryCellDelegate: class{
    optional func categoryCell(categoryCell: CategoryCell, didValueChange value: Bool)
}

class CategoryCell: UITableViewCell {

    weak var delegate: CategoryCellDelegate?
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categorySwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categorySwitch.addTarget(self, action: "switchValueChange", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChange(){
        delegate?.categoryCell!(self, didValueChange: categorySwitch.on)
    }

}
