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
//    {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //MARK DANIEL: CON ESTO TE TRAE LA DATA. LO HACE CON CORE DATA SI QUIERES HAZLO CON EL DIDSET COMO GUSTES
        getRestaurantData { (response, error) in
            if error == nil {
                self.restaurants = response
                print("Hay Data \(self.restaurants.count)")
                
            }
        }
        
        
        
        //MARK:ESTO TE LO COMENTE
        /*Repository.getRestaurant {(response, error) in
            if error != nil {
                print("\(error.debugDescription)")
            } else {
                for (subJson):(JSON) in response! {
                    // Do something you want
                    let restaurant = Restaurant(name: subJson["name"].string!, description: subJson["description"].string!, thumbnail: subJson["thumbnail"].string!, rating: subJson["rating"].double!, address: subJson["address"].string!, phone: subJson["phone"].string!, latitude: subJson["latitude"].double!, longitude: subJson["latitude"].double!)
                    self.restaurants.append(restaurant)
                }
                self.tableView.reloadData()
            }
        }*/
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
