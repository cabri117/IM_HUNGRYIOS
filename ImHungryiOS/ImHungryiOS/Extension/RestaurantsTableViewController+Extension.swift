//
//  RestaurantsTableViewController+Extension.swift
//  ImHungryiOS
//
//  Created by Daniel Cabrera on 1/22/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//
import UIKit
extension RestaurantsTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredRestaurants = restaurants.filter({( rest : Restaurant) -> Bool in
            return rest.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}
