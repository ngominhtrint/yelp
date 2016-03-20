//
//  FiltersCell.swift
//  Yelp
//
//  Created by TriNgo on 3/18/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersCellDelegate: class{
    optional func filtersCell(filtersCell: FiltersCell, didChangeValue value: Bool)
}

class FiltersCell: UITableViewCell {
    
    weak var delegate: FiltersCellDelegate?

    @IBOutlet weak var offerDealSwitch: UISwitch!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        offerDealSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged(){
        delegate?.filtersCell?(self, didChangeValue: offerDealSwitch.on)
    }

}
