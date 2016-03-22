//
//  FiltersViewController.swift
//  Yelp
//
//  Created by TriNgo on 3/17/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate: class{
    optional func filterViewController(filtersViewController: FiltersViewController, didUpdateFilters filter: Filter)
}

class FiltersViewController: UIViewController {
    
    weak var delegate: FiltersViewControllerDelegate?
    var searchData: Filter?
    
    var switchStates = [Int:Bool]()
    var distanceSwitchStates = [Int:Bool]()
    var sortBySwitchStates = [Int:Bool]()
    var categoriesSwitchStates = [Int:Bool]()
    
    let sortBy = [YelpSortMode.BestMatched, YelpSortMode.Distance, YelpSortMode.HighestRated]
    let distances = [25, 0.3, 1, 3, 5]
    let categories = ["homeandgarden", "flowers", "fashion"]
    
    let data = [("", ["Offering a Deal"]),
        ("Distance", ["Auto", "0.3 miles", "1 miles", "3 miles", "5 miles"]),
        ("Sort By", ["Best Match", "Distance", "High Rated"]),
        ("Category", ["Home & Garden", "Flowers & Gifts", "Fashion"])]
    let FiltersCellIdentifier = "FiltersCell", DistanceCellIdentifier = "DistanceCell", HeaderViewIdentifier = "HeaderCell", SortByCellIdentifier = "SortByCell", CategoryCellIdentifier = "CategoryCell"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        
        searchData = Filter()
        searchData!.category = []
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func preferencesFromSearchData() -> Filter{
        let filter = Filter()
        return filter
    }
    
    @IBAction func onCancelClicked(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearchClicked(sender: UIBarButtonItem) {
        for (var index = 0; index < categoriesSwitchStates.count; index++){
            if (categoriesSwitchStates[index] != nil && categoriesSwitchStates[index] == true){
                searchData!.category.append(categories[index])
            }
        }

        delegate?.filterViewController!(self, didUpdateFilters: searchData!)
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].1.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch (indexPath.section){
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(FiltersCellIdentifier, forIndexPath: indexPath) as! FiltersCell
            cell.selectionStyle = .None
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.grayColor().CGColor
            cell.layer.cornerRadius = 4.0
            
            cell.delegate = self
        
            let dataInSections = data[indexPath.section].1
            cell.categoryLabel.text = dataInSections[indexPath.row]
            cell.offerDealSwitch.on = switchStates[indexPath.row] ?? false
            return cell
        
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(DistanceCellIdentifier, forIndexPath: indexPath) as! DistanceCell
            drawCornerGrayBorder(cell)
            cell.delegate = self
            
            let dataInSections = data[indexPath.section].1
            cell.distanceLabel.text = dataInSections[indexPath.row]
            cell.distanceSwitch.on = distanceSwitchStates[indexPath.row] ?? false
            return cell
        
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(SortByCellIdentifier, forIndexPath: indexPath) as! SortByCell
            drawCornerGrayBorder(cell)
            
            cell.delegate = self
            
            let dataInSections = data[indexPath.section].1
            cell.sortByLabel.text = dataInSections[indexPath.row]
            cell.sortBySwitch.on = sortBySwitchStates[indexPath.row] ?? false
            return cell

        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier(CategoryCellIdentifier, forIndexPath: indexPath) as! CategoryCell
            drawCornerGrayBorder(cell)
            
            cell.delegate = self
            
            let dataInSections = data[indexPath.section].1
            cell.categoryLabel.text = dataInSections[indexPath.row]
            cell.categorySwitch.on = categoriesSwitchStates[indexPath.row] ?? false
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(FiltersCellIdentifier, forIndexPath: indexPath) as! FiltersCell
            drawCornerGrayBorder(cell)
            cell.delegate = self
            
            let citiesInSection = data[indexPath.section].1
            cell.categoryLabel.text = citiesInSection[indexPath.row]
            cell.offerDealSwitch.on = switchStates[indexPath.row] ?? false
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier)! as UITableViewHeaderFooterView
        header.layer.backgroundColor = UIColor.whiteColor().CGColor
        header.textLabel!.text = data[section].0
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0){
            return 0
        }
        return 50
    }
    
    func drawCornerGrayBorder(cell: UITableViewCell){
        cell.selectionStyle = .None
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.grayColor().CGColor
        cell.layer.cornerRadius = 4.0
    }
}

// FiltersCellDelegate
extension FiltersViewController: FiltersCellDelegate{
    func filtersCell(filtersCell: FiltersCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(filtersCell)!
        
        switchStates[indexPath.row] = value
        searchData?.offerDeal = switchStates[indexPath.row]
    }
}

// DistanceCellDelegate
extension FiltersViewController: DistanceCellDelegate{
    func distanceCell(distanceCell: DistanceCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(distanceCell)!
        distanceSwitchStates[indexPath.row] = value
        
        if (distanceSwitchStates[indexPath.row] != nil && distanceSwitchStates[indexPath.row] == true){
            searchData?.distance = distances[indexPath.row] * searchData!.mileToMeter
        }
    }
}

extension FiltersViewController: SortByCellDelegate{
    func sortByCell(sortByCell: SortByCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(sortByCell)!
        sortBySwitchStates[indexPath.row] = value
        
        if (sortBySwitchStates[indexPath.row] != nil && sortBySwitchStates[indexPath.row] == true){
            searchData?.sortBy = sortBy[indexPath.row]
        }
    }
}

extension FiltersViewController: CategoryCellDelegate{
    func categoryCell(categoryCell: CategoryCell, didValueChange value: Bool) {
        let indexPath = tableView.indexPathForCell(categoryCell)!
        categoriesSwitchStates[indexPath.row] = value
    }
    
}











