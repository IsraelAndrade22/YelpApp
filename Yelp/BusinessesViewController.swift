//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var businesses: [Business]!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchController: UISearchController!
    
    var typeOfFood: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
//        searchBar.delegate = self
//
//        searchBar.returnKeyType = UIReturnKeyType.done
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchDisplayController?.displaysSearchBarInNavigationBar = true
        print(searchBar.text)
        if(typeOfFood == nil) {
            typeOfFood = "Mexican"
        }
        /*
        //using search controller
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
 */
        
        //searchController.hidesNavigationBarDuringPresentation = false
        Business.searchWithTerm(term: typeOfFood, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if(searchBar.text == nil || searchBar.text == "") {
//            view.endEditing(true)
//            tableView.reloadData()
//        } else {
//            typeOfFood = searchBar.text
//            tableView.reloadData()
//        }
//    }
    
}
