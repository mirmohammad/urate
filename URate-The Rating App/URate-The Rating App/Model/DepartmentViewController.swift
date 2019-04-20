//
//  DepartmentViewController.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-19.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import Firebase

class DepartmentViewController: UITableViewController{
    
    let getDepartmentID = "Department1"
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //database handler
    var databaseHandle: DatabaseHandle?
    
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        //set the firebase refrence
        ref = Database.database().reference()
        
        ref?.child("Departments").child(getDepartmentID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            //Get deparments values
            
            if let values = snapshot.value as? NSDictionary {
                
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

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
