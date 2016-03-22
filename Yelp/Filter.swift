//
//  Filters.swift
//  Yelp
//
//  Created by TriNgo on 3/17/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class Filter: NSObject {

    let mileToMeter = 1609.3
    var offerDeal: Bool!
    var distance: Double!
    var sortBy: YelpSortMode!
    var category: [String]!
    
    override init() {
        offerDeal = false
        distance = 25 * mileToMeter
        sortBy = YelpSortMode.BestMatched
        category = [""]
    }
    
}
