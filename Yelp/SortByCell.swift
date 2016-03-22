//
//  SortByCell.swift
//  Yelp
//
//  Created by TriNgo on 3/21/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SortByCellDelegate: class{
    optional func sortByCell(sortByCell: SortByCell, didChangeValue value: Bool)
}

class SortByCell: UITableViewCell {

    weak var delegate: SortByCellDelegate?
    
    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var sortBySwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sortBySwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged(){
        delegate?.sortByCell!(self, didChangeValue: sortBySwitch.on)
    }

}
