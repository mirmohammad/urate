//
//  ContactTableViewCell.swift
//  URate-The Rating App
//
//  Created by Minh Le on 2019-05-08.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import MessageUI
import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var btnCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if (selected == true){
            super.setSelected(true, animated: animated)
            btnCheck.image = UIImage(named: "check")
            
        }
        else{
            super.setSelected(false, animated: animated)
            btnCheck.image = UIImage(named: "empty")
            backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        
    }
    
    
}



