//
//  DeparmentViewController.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-27.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import Firebase

class DeparmentViewController: UITableViewController {
    
    //Information comes from the list of departments
    var getDeparmentID:String!
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //database handler
    var databaseHandle: DatabaseHandle?
    
    @IBOutlet weak var departmentLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    
    @IBOutlet weak var feedbackButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        //set the firebase refrence
        ref = Database.database().reference()
        
        ref?.child("Deparments").child(getDeparmentID).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            
            
            if let values = DataSnapshot.value as? NSDictionary {
                
                let name = values["name"] as! String
                let location = values["location"] as! String
                let phone = values["phone_number"] as! String
                let desc = values["long_desc"] as! String
                
                self.departmentLabel.text = name
                self.locationLabel.text = location
                self.phoneLabel.text = phone
                self.descLabel.text = desc
                
                self.tableView.reloadData()
                
            }
            
        })
        
        feedbackButton.layer.cornerRadius = 16
        feedbackButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        feedbackButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        feedbackButton.layer.masksToBounds = true

    }

}
