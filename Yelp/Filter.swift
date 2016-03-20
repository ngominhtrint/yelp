//
//  Filters.swift
//  Yelp
//
//  Created by TriNgo on 3/17/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class Filter: NSObject {

    var offerDeal: Bool!
    var distance: String!
    var sortBy: YelpSortMode!
    var category: [String]!
    
    override init() {
        offerDeal = false
        distance = ""
        sortBy = YelpSortMode.BestMatched
        category = [""]
    }
    
}
