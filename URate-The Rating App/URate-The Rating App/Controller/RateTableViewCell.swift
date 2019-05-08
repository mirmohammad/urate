//
//  RateTableViewCell.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-27.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints

class RateTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ratingView.settings.updateOnTouch = false
        ratingView.settings.starMargin = 3
        ratingView.settings.fillMode = .precise
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
