//
//  DepartmentViewController.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-19.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import Firebase

class DepartmentViewController: UIViewController {
    
    let getDepartmentID = "Department1"

    @IBOutlet weak var departmentNameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //database handler
    var databaseHandle: DatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the firebase refrence
        ref = Database.database().reference()
        
        ref?.child("Departments").child(getDepartmentID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            //Get deparments values
            
            let values = snapshot.value as? NSDictionary
            let name = values?["name"] as! String
            let location = values?["location"] as! String
            
            self.departmentNameLabel.text = name
            self.locationLabel.text = location
            
            
        })

        // Do any additional setup after loading the view.
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
