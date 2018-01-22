//
//  RestaurantAnnotation.swift
//  ImHungryiOS
//
//  Created by Misael Cuevas Vásquez on 1/22/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import UIKit
import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    let restaurant: Restaurant?
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.title = restaurant.name
        self.locationName = restaurant.address
        self.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
