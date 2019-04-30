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
    
    var listRates = [Rate]()
    
    var depRates = [Rate]()

    
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
        
        fetchDepRates()
        
        var found = false
        
        for rate in depRates {
            
            if rate.user_id == uId {
                print("User already rated this department")
                found = true
                break
            }
            
        }
        
        if !found {
            
            let rate = self.userRate.rating
            
            let values = ["user_id": uId, "dep_id": self.getdep_id!, "comment":  self.userComment.text ?? "", "rate" : rate] as [String : Any]
            
            self.ref?.child("Rate").childByAutoId().setValue(values) {
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
    
    func fetchDepRates () {
        
        let databaseLoader = DispatchQueue.global(qos: .background)
        let loadingGroup = DispatchGroup()
        
        loadingGroup.enter()
        databaseLoader.async {
            
            self.ref!.child("Rate").observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dict = snapshot.value as? [String:[String: Any]] else {
                    fatalError("Bye!")
                }
                for (_, rate) in dict {
                    
                    let newRate = Rate(userID: rate["user_id"] as! String, depID: rate["dep_id"] as! String, comment: rate["comment"] as! String, rate: rate["rate"] as! Int, userName: "Empty")
                    
                    self.listRates.append(newRate)
                }
                loadingGroup.leave()
            }, withCancel: nil)
        }
        
        loadingGroup.notify(queue: .main) {
            databaseLoader.async {
                for rate in self.listRates {
                    if rate.dep_id == self.getdep_id{
                        self.depRates.append(rate)
                    }
                }
            }
        }
    }

}
