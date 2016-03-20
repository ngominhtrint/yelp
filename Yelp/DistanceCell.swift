//
//  DistanceCell.swift
//  Yelp
//
//  Created by TriNgo on 3/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DistanceCellDelegate: class{
    optional func distanceCell(distanceCell: DistanceCell, didChangeValue value: Bool)
}

class DistanceCell: UITableViewCell {
    
    weak var delegate: DistanceCellDelegate?

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var checkBox: CheckBox!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onChecked(sender: CheckBox) {
        delegate?.distanceCell!(self, didChangeValue: checkBox.isChecked)
    }
    
}
