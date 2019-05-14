//
//  ListCommentTableController.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-27.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import Firebase
class ListCommentTableController: UITableViewController {

    var getDeparmentID:String!
    var listRates = [Rate]()
    var depRates = [Rate]()
    var cellid = "CellId"
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //database handler
    var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getDeparmentID!)
        
        ref = Database.database().reference()
        
        fetchRates()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return depRates.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! RateTableViewCell

        ref!.child("users").child(depRates[indexPath.row].user_id!).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                
                let name = dictionary["firstName"] as! String
                let surname = dictionary["lastName"] as! String
                
                self.depRates[indexPath.row].user_name = name + ", " + surname
            }
            
            cell.usernameLabel.text = self.depRates[indexPath.row].user_name
            cell.commentLabel.text = self.depRates[indexPath.row].comment
            cell.ratingView.rating = Double(self.depRates[indexPath.row].rate ?? 0)
            
        }
        return cell
    }
}

extension ListCommentTableController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as! DetailCommentController
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("No item selected")
        }
        
        controller.getComment = depRates[indexPath.row].comment
        controller.getUsername = depRates[indexPath.row].user_name

    }
    
    func fetchRates () {
        
        ref!.child("Rate").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String:[String: Any]] {
                for (_,rate) in dictionary{
                    
                    let newRate = Rate(userID: rate["user_id"] as! String, depID: rate["dep_id"] as! String, comment: rate["comment"] as! String, rate: rate["rate"] as! Int, userName: "Empty")
                    self.listRates.append(newRate)
                }
                
                for rate in self.listRates {
                    if rate.dep_id == self.getDeparmentID{
                        self.depRates.append(rate)
                    }
                }
                
                self.tableView.reloadData()
                
            }
            
        }, withCancel: nil)
        
//        let databaseLoader = DispatchQueue.global(qos: .background)
//        let loadingGroup = DispatchGroup()
//
//        loadingGroup.enter()
//        databaseLoader.async {
//
//            self.ref!.child("Rate").observeSingleEvent(of: .value, with: { (snapshot) in
//
//                print(snapshot)
//                guard let dict = snapshot.value as? [String:[String: Any]] else {
//                    fatalError("Bye!")
//                }
//                for (_, rate) in dict {
//
//                    let newRate = Rate(userID: rate["user_id"] as! String, depID: rate["dep_id"] as! String, comment: rate["comment"] as! String, rate: rate["rate"] as! Int, userName: "Empty")
//
//                    print(newRate)
//                    self.listRates.append(newRate)
//                }
//                loadingGroup.leave()
//            }, withCancel: nil)
//
//        }
//
//
//        loadingGroup.notify(queue: .main) {
//            databaseLoader.async {
//                for rate in self.listRates {
//                    if rate.dep_id == self.getDeparmentID{
//                        self.depRates.append(rate)
//                    }
//                }
//            }
//        }
    }
    
}
