//
//  CreateRateTableController.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-27.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

class CreateRateTableController: UITableViewController {
    
    var ref: DatabaseReference?
    
    var databaseHandle: DatabaseHandle?
    
    var getdep_id:String!

    
    @IBOutlet weak var userRate: CosmosView!
    
    @IBOutlet weak var userComment: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        ref = Database.database().reference()
        
        

    }
    
    @IBAction func cancelRate(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveRate(_ sender: UIBarButtonItem) {
        
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        
        let rate = userRate.rating
        
        let values = ["user_id": uId, "dep_id": getdep_id!, "comment":  userComment.text ?? "", "rate" : userRate!] as [String : Any]
        
        ref?.child("Rate").childByAutoId().setValue(values) {
            (err, ref) in
            if err != nil {
                print(err!)
                return
            } else {
                print("Uploaded!!!")
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }

}
