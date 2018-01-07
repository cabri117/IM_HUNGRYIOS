//
//  Repository.swift
//  ImHungryiOS
//
//  Created by Daniel Cabrera on 12/24/17.
//  Copyright © 2017 Daniel Cabrera. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Repository {
    
    class func getRestaurant(completionHandler: @escaping ([JSON]?, Error?) -> ()) {
        request(url, method: .get)
            .responseJSON { dataResponse in
                if dataResponse.error == nil {
                    if let array = JSON(dataResponse.data!).arrayValue as [JSON]?{
                        completionHandler(array , nil)
                    } else {
                        completionHandler(nil ,"Parse error" as? Error)
                    }
                }  else {
                    completionHandler(nil , dataResponse.error)
                }
        }
    }
}
