//
//  RestaurantDetailViewController.swift
//  ImHungryiOS
//
//  Created by Misael Cuevas Vásquez on 1/22/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var ivThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var topDescription: NSLayoutConstraint!
    @IBOutlet weak var heightViewContainer: NSLayoutConstraint!
    
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnMap: UIButton!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        heightViewContainer.constant = txtContent.frame.height + 320
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpViews() {
        
        btnCall.layer.cornerRadius = 10
        btnCall.clipsToBounds = true
        
        btnMap.layer.cornerRadius = 10
        btnMap.clipsToBounds = true
        
        if restaurant == nil {
            return
        }
        
        title = restaurant.name
        
        if !restaurant.thumbnail.isEmpty {
            self.ivThumbnail.kf.setImage(with: URL(string: restaurant.thumbnail)!,
                                         placeholder: UIImage(named: "AppIcon")!,
                                         options: [.transition(.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
            
        } else {
            self.ivThumbnail.image = UIImage(named: "AppIcon")!
        }
        
        lblTitle.text = restaurant.name
        lblSubTitle.text = "\(restaurant.phone) - \(restaurant.address)"
        txtContent.text = restaurant.description
    }
    
    @IBAction func onCallPressed(_ sender: Any) {
        if restaurant == nil {
            return
        }
        
        if let url = URL(string: "tel://\(restaurant.phone)") {
            openUrl(url: url)
        }
    }
    
    @IBAction func onMapPressed(_ sender: Any) {
        
        if restaurant == nil {
            return
        }
        
        let directionUrl = "http://maps.apple.com/?daddr=\(restaurant.latitude),\(restaurant.longitude)&dirflg=\(NAV_MODE)"
        
        if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com")!)) {
            openUrl(url: URL(string: directionUrl)!)
        } else {
            NSLog("Can't use Apple Maps");
        }
    }
    
    func openUrl(url : URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
