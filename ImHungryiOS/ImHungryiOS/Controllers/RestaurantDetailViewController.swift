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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
