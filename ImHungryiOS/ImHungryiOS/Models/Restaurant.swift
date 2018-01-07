//
//  Restaurant.swift
//  ImHungryiOS
//
//  Created by Misael Cuevas Vásquez on 1/1/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    let name, description, thumbnail: String
    let rating: Double
    let address, phone: String
    let latitude, longitude: Double
}



