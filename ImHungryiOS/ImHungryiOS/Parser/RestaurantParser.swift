//
//  RestaurantParser.swift
//  ImHungryiOS
//
//  Created by Daniel Cabrera on 1/7/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import Foundation

class Parser {
    
    class func getRestaurant(completionHandler: @escaping ([Restaurant], Error?) -> ()) {
        Repository.getRestaurant { (response, error) in
            var mRestaurant : [Restaurant] = []
            if error == nil {
                
                for restObj in response! {
                    let rest = Restaurant(name: restObj["name"].string!, description: restObj["description"].string!, thumbnail: restObj["thumbnail"].string!,rating:restObj["rating"].double!, address:restObj["address"].string!, phone:restObj["phone"].string!, latitude:restObj["latitude"].double!, longitude:restObj["longitude"].double! )
                    mRestaurant.append(rest)
                }
                completionHandler(mRestaurant, nil)
            } else {
                completionHandler([], error)
            }
            
        }
    }
}
