//
//  RestaurantsTableViewCell.swift
//  ImHungryiOS
//
//  Created by Misael Cuevas Vásquez on 1/1/18.
//  Copyright © 2018 Daniel Cabrera. All rights reserved.
//

import UIKit
import Kingfisher

class RestaurantsTableViewCell: UITableViewCell {

    @IBOutlet weak var ivThumbnail: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    var restaurant : Restaurant! {
        didSet {
            lblName.text = restaurant.name
            lblDistance.text = restaurant.phone
            
            if  !restaurant.thumbnail.isEmpty {
               self.ivThumbnail.kf.setImage(with: URL(string: restaurant.thumbnail)!,
                                                 placeholder: nil,
                                                 options: [.transition(.fade(1))],
                                                 progressBlock: nil,
                                                 completionHandler: nil)
            } else {
                self.ivThumbnail.image = UIImage(named: "AppIcon")!
            }
            
            self.ivThumbnail.layer.cornerRadius = self.ivThumbnail.frame.size.width / 2
            self.ivThumbnail.clipsToBounds = true
        }
    }
    
    // override selected property
    override var isSelected : Bool {
        // once the cell (de)selects, change the background color
        didSet{
            
            if isSelected{
                // user selected cell
                self.backgroundColor = UIColor.lightGray
            }else{
                // cell was deselected
                self.backgroundColor = UIColor.white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
