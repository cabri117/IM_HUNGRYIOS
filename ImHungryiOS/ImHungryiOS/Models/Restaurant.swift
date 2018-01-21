//
//  Restaurant.swift
//  ImHungryiOS
//
//  Created by Misael Cuevas Vásquez on 1/1/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct Restaurant: Codable {
    let name, description, thumbnail: String
    let rating: Double
    let address, phone: String
    let latitude, longitude: Double
}

func getRestaurantData (completionHandler: @escaping ([Restaurant], Error?) -> ()) {
    var mRestaurant : [Restaurant] = []
    Parser.getRestaurant {(response, error) in
        if error != nil {
            mRestaurant = mRestaurantCoreDatafetch()
            completionHandler(mRestaurant, nil)
        } else {
            mRestaurantCoreDataDelete()
            mRestaurant = response
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            // 1
            let managedContext =
                appDelegate.persistentContainer.viewContext
            // 2
            let entity =
                NSEntityDescription.entity(forEntityName: "Restaurants",
                                           in: managedContext)!
            
            for restObj in response {
                let rest = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
                // Aqui guardamos la data del servidor en CoreData
                rest.setValue(restObj.name, forKeyPath: "name")
                rest.setValue(restObj.description, forKeyPath: "rest_description")
                rest.setValue(restObj.address, forKeyPath: "address")
                rest.setValue(restObj.latitude, forKeyPath: "latitude")
                rest.setValue(restObj.longitude, forKeyPath: "longitude")
                rest.setValue(restObj.phone, forKeyPath: "phone")
                rest.setValue(restObj.rating, forKeyPath: "rating")
                rest.setValue(restObj.thumbnail, forKeyPath: "thumbnail")
                // 4
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                    completionHandler([], error)
                }
            }
            
            completionHandler(mRestaurant, nil)
            
        }
    }
}



func mRestaurantCoreDataDelete() {
    
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    
    let managedContext =
        appDelegate.persistentContainer.viewContext
    // Create Fetch Request
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurants")
    
    // Create Batch Delete Request
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
        try managedContext.execute(batchDeleteRequest)
        
    } catch {
        // Error Handling
    }
}

func mRestaurantCoreDatafetch() -> [Restaurant] {
    var mRestaurant: [Restaurant] = []
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return []
    }
    
    let managedContext =
        appDelegate.persistentContainer.viewContext
    
    //2
    let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Restaurants")
    
    //3
    do {
       let restaurant = try managedContext.fetch(fetchRequest)
        
        for restObj in restaurant {
            
            let rest = Restaurant(name: restObj.value(forKey: "name") as! String, description: restObj.value(forKey: "rest_description") as! String, thumbnail: restObj.value(forKey: "thumbnail") as! String,rating: restObj.value(forKey: "rating") as! Double, address: restObj.value(forKey: "address") as! String, phone: restObj.value(forKey: "phone") as! String, latitude: restObj.value(forKey: "latitude") as! Double, longitude: restObj.value(forKey: "longitude") as! Double )
            mRestaurant.append(rest)
            
        }
        
        
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    
    return mRestaurant
    
}



