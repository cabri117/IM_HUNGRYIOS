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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
