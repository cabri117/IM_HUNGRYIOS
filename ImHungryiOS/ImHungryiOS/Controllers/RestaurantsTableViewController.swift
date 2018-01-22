//
//  RestaurantsTableViewController.swift
//  ImHungryiOS
//
//  Created by Misael Cuevas Vásquez on 1/1/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import UIKit
import SwiftyJSON

class RestaurantsTableViewController: UITableViewController {

    var restaurants : [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "I'm Hungry"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadRestaurants()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.addTarget(self,
                                            action: #selector(refreshControlAction(_:)),
                                            for: .valueChanged)
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
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RestaurantsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "RestaurantsCell", for: indexPath) as! RestaurantsTableViewCell
        
        cell.restaurant = self.restaurants[(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueDetails", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let detailsViewController = segue.destination as! RestaurantDetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        detailsViewController.restaurant = restaurants[indexPath!.row]
    }
}
