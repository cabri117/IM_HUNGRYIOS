//
//  RestaurantMapViewController.swift
//  ImHungryiOS
//
//  Created by Misael Cuevas Vásquez on 1/22/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurants : [Restaurant] = []
    var selectedRestaurant: Restaurant?
    var locationManager : CLLocationManager?
    
    var dismissBlock: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mapa"
        
        mapView.delegate = self
        
        let button = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(dismiss(_:)))
        button.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.blue], for: .normal)
        navigationItem.rightBarButtonItem = button
        
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        if restaurants.count != 0 {
            var annotations : [RestaurantAnnotation] = []
            
            for restaurant in restaurants {
                let annotation = RestaurantAnnotation(restaurant: restaurant)
                annotations.append(annotation)
            }
            self.mapView.showAnnotations(annotations, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Pull To Dismiss ViewController
    @objc func dismiss(_: AnyObject?) {
        dismiss(animated: true) { [weak self] in
            self?.dismissBlock?()
        }
    }
    
    // MARK: - Maps
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? RestaurantAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                dequeuedView.annotation = annotation
                view = dequeuedView as! MKPinAnnotationView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! RestaurantAnnotation
        
        self.selectedRestaurant = location.restaurant!
        self.performSegue(withIdentifier: "segueDetails", sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let detailsViewController = segue.destination as! RestaurantDetailViewController
        detailsViewController.restaurant = selectedRestaurant
    }
}
