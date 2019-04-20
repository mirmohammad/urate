//
//  RateTableViewCell.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-19.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
