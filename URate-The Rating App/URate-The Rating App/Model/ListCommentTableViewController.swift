//
//  ListCommentTableViewController.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-19.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import Firebase

class ListCommentTableViewController: UITableViewController {
    
    var getDeparmentID = "Department1"
    
    let cellid = "CellId"
    
    var listAllRates = [Rate]()
    
    var depRate = [Rate]()
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //database handler
    var databaseHandle: DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        fetchComments()
        
        getUsersName()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getUsersName(){
        
        
        
    }
    
    func fetchComments(){
        
        ref!.child("Rate").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String:[String: Any]] {
                for (_,rate) in dictionary{
                    
                    let newRate = Rate()
                    newRate.comment = (rate["comment"] as! String)
                    newRate.dep_id = (rate["dep_id"] as! String)
                    newRate.rate = (rate["rate"] as! Int)
                    newRate.user_id = (rate["user_id"] as! String)
                    self.listAllRates.append(newRate)
                }
                
                for rate in self.listAllRates {
                    if rate.dep_id == self.getDeparmentID{
                        self.depRate.append(rate)
                    }
                }
                
//                DispatchQueue.main.async {
//                    for rate in self.depRate {
//                        self.ref!.child("users").child(rate.user_id!).observeSingleEvent(of: .value, with: { (snapshot) in
//                            print(snapshot)
//
//                            if let dictionary = snapshot.value as? [String: Any] {
//
//                                let name = dictionary["firstName"] as! String
//                                let surname = dictionary["lastName"] as! String
//
//                                rate.user_name = name + "," + surname
//
//                                print(rate.user_name)
//
//                            }
//
//                        })
//
//                        print(self.depRate)
//                    }
//                }
                
                self.tableView.reloadData()
                
            }
            
        }, withCancel: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detail = segue.destination as! DetailCommentViewController
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        detail.getComment = depRate[indexPath.row].comment
        detail.getUsername = depRate[indexPath.row].user_name
        
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return depRate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! RateTableViewCell
        
        ref!.child("users").child(depRate[indexPath.row].user_id!).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                
                let name = dictionary["firstName"] as! String
                let surname = dictionary["lastName"] as! String
                
                self.depRate[indexPath.row].user_name = name + ", " + surname
            }
            
            cell.usernameLabel.text = self.depRate[indexPath.row].user_name
            cell.commentLabel.text = self.depRate[indexPath.row].comment
        
        }
        
        
        
        
        
        return cell
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
