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
    
    var categories: [[String:String]]!
    var switchStates = [Int:Bool]()
    let data = [("", ["Offering a Deal"]),
        ("Distance", ["Auto", "0.3 miles", "1 miles", "3 miles", "5 miles"]),
        ("Sort By", ["Best Match", "Distance", "High Rated"]),
        ("Category", ["Afghan", "African", "American (New)"])]
    let FiltersCellIdentifier = "FiltersCell", DistanceCellIdentifier = "DistanceCell", HeaderViewIdentifier = "HeaderCell"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        
        searchData = Filter()
//        categories = yelpCategories()
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
        searchData!.distance = ""
        searchData!.sortBy = YelpSortMode.BestMatched
        searchData!.category = [""]
        delegate?.filterViewController!(self, didUpdateFilters: searchData!)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func yelpCategories() -> [[String:String]]{
        return [["name" : "Afghan", "code" : "afghani"],
        ["name" : "American, New", "code" : "newamerican"],
        ["name" : "American, Traditional", "code" : "tradamerican"],
        ["name" : "Arabian", "code" : "arabian"],
        ["name" : "Argentine", "code" : "argentine"],
        ["name" : "Armenian", "code" : "armenian"],
        ["name" : "Asian Fusion", "code" : "asian fusion"],
        ["name" : "Asturian", "code" : "asturian"],
        ["name" : "Australian", "code" : "australian"],
        ["name" : "Autrian", "code" : "autrian"],
        ["name" : "Baguettes", "code" : "baguettes"],
        ["name" : "Bangladeshi", "code" : "bangladeshi"],
        ["name" : "Bavarian", "code" : "bavarian"],
        ["name" : "Beer Garden", "code" : "beergarden"],
        ["name" : "Belgian", "code" : "belgian"],
        ["name" : "Bistros", "code" : "bistros"]]
    }

}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource, FiltersCellDelegate {
    
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
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.grayColor().CGColor
            cell.layer.cornerRadius = 4.0
            
            let dataInSections = data[indexPath.section].1
            cell.distanceLabel.text = dataInSections[indexPath.row]
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(FiltersCellIdentifier, forIndexPath: indexPath) as! FiltersCell
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.grayColor().CGColor
            cell.layer.cornerRadius = 4.0
            
            cell.delegate = self
            
            let citiesInSection = data[indexPath.section].1
            cell.categoryLabel.text = citiesInSection[indexPath.row]
            cell.offerDealSwitch.on = switchStates[indexPath.row] ?? false
            return cell
        }
        
    }
    
    func filtersCell(filtersCell: FiltersCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(filtersCell)!
        
        switchStates[indexPath.row] = value
        searchData?.offerDeal = switchStates[indexPath.row]
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
}












