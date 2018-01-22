//
//  Connectivity.swift
//  ImHungryiOS
//
//  Created by Misael Cuevas Vásquez on 1/22/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
