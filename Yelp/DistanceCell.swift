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

    @IBOutlet weak var distanceSwitch: UISwitch!
    @IBOutlet weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        distanceSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged(){
        delegate?.distanceCell!(self, didChangeValue: distanceSwitch.on)
    }
    
}
