//
//  ImHungryiOSTests.swift
//  ImHungryiOSTests
//
//  Created by Daniel Cabrera on 12/12/17.
//  Copyright © 2017 Daniel Cabrera. All rights reserved.
//

import XCTest
import CoreData

@testable import ImHungryiOS
@testable import SwiftyJSON
@testable import Alamofire


class ImHungryiOSTests: XCTestCase {
    
    var restaurant: [NSManagedObject] = []
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAsyncRepository() {
        let expect = expectation(description: "Testing")
        Repository.getRestaurant {(response, error) in
            if error != nil {
                XCTFail((error?.localizedDescription)!)
            } else {
                XCTAssert(response!.count > 0, "No hay data")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0, handler: { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
        })
        
    }
    
    func testCoreDatasave() {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                XCTFail("Fallo")
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        XCTAssertNotNil(NSEntityDescription.entity(forEntityName: "Restaurants",
                                                in: managedContext)!, "Es Nil")
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Restaurants",
                                       in: managedContext)!
        
        let rest = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        // 3
        rest.setValue("Daniel", forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            XCTFail("Fallo")
        }
    }
    
    func testCoreDatafetch() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                XCTFail("Fallo")
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Restaurants")
        
        //3
        do {
            restaurant = try managedContext.fetch(fetchRequest)
            print("cuanta Data hay \(String(restaurant.count))")
            XCTAssert(restaurant.count > 0, "No hay data")
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            XCTFail("Fallo")
        }
        
    }
    
}
