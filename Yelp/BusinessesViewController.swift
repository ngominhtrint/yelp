//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController {

    var searchBar: UISearchBar!
    var businesses: [Business]!
    var filterData: Filter?
    
    var searchContent:String = ""
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
//        tableView.sectionIndexBackgroundColor = .None
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        filterData = Filter()
        doSearch()
/*
// Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
        */
    }
    
    func doSearch(){
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading"
        
        print("\n========\nsearchContent \(searchContent)")
        print("offerDeal \(filterData!.offerDeal)")
        print("distance \(filterData!.distance)")
        print("sortBy \(filterData!.sortBy)")
        print("Category \(filterData!.category)\n========\n")
        
        Business.searchWithTerm(searchContent, sort: filterData!.sortBy, categories: filterData!.category,
            deals: filterData!.offerDeal, distance: filterData!.distance, completion: { (businesses: [Business]!, error: NSError!) -> Void in

                if (businesses != nil){
                    self.businesses = businesses
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                }
                self.tableView.reloadData()
                progressHUD.hide(true)
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let navigationViewController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationViewController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
        
//        filtersViewController.searchData = self.filterData
        
        
    }

}

// Search Bar methods
extension BusinessesViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchContent = searchBar.text!
        searchBar.resignFirstResponder()
        doSearch()
    }
}

// Table View methods
extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as! RestaurantCell
        cell.selectionStyle = .None
        let business = businesses[indexPath.row]

        cell.rateImageView.setImageWithURL(business.ratingImageURL!)
        cell.restaurantImageView.setImageWithURL(business.imageURL!)
        cell.restaurantNameLabel.text = business.name
        cell.distancesLabel.text = String(business.distance!)
        cell.reviewsLabel.text = "\(String(business.reviewCount!)) Reviews"
        cell.addressLabel.text = business.address
        cell.categoriesLabel.text = business.categories 
        
        return cell
    }
}

// Back from FiltersViewController
extension BusinessesViewController: FiltersViewControllerDelegate{
    func filterViewController(filtersViewController: FiltersViewController, didUpdateFilters filter: Filter) {
        self.filterData = filter
        doSearch()
    }
}









