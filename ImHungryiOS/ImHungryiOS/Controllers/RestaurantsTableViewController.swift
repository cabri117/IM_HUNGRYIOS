//
//  RestaurantsTableViewController.swift
//  ImHungryiOS
//
//  Created by Misael Cuevas Vásquez on 1/1/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import UIKit
import SwiftyJSON

class RestaurantsTableViewController: UITableViewController, UISearchBarDelegate {

    var restaurants : [Restaurant] = []
    var filteredRestaurants = [Restaurant]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "I'm Hungry"
        
        
        loadRestaurants()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.addTarget(self,
                                            action: #selector(refreshControlAction(_:)),
                                            for: .valueChanged)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar restaurantes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        let mapButton = UIBarButtonItem(title: "Mapa", style: .plain, target: self, action: #selector(mapAction(_:)))
        self.navigationItem.rightBarButtonItem = mapButton
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshControlAction(_ sender : UIRefreshControl) {
        loadRestaurants()
        sender.endRefreshing()
    }
    
    func loadRestaurants() {
        if !Connectivity.isConnectedToInternet() {
            let alertController = UIAlertController(title: "", message:
                "Actualmente no tienes conectividad a internet. Se mostrarán los últimos restaurantes guardados en su dispositivo.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
      
        getRestaurantData { (response, error) in
            if error == nil {
                self.restaurants = response
                print("Hay Data \(self.restaurants.count)")
                self.tableView.reloadData()
            } else {
                
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredRestaurants.count
        } 
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RestaurantsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "RestaurantsCell", for: indexPath) as! RestaurantsTableViewCell
        if isFiltering() {
            cell.restaurant = self.filteredRestaurants[(indexPath as NSIndexPath).row]
        } else {
            cell.restaurant = self.restaurants[(indexPath as NSIndexPath).row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueDetails", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsViewController = segue.destination as! RestaurantDetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        detailsViewController.restaurant = restaurants[indexPath!.row]
    }
    
    @objc func mapAction(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mapViewController") as! RestaurantMapViewController
        vc.restaurants = restaurants
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
}
