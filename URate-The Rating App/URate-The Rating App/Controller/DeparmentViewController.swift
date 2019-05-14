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
    var getDeparment:Department!
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //database handler
    var databaseHandle: DatabaseHandle?
    
    @IBOutlet weak var departmentLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var depImage: UIImageView!
    
    
    
    @IBOutlet weak var feedbackButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        //set the firebase refrence
        ref = Database.database().reference()
        
        departmentLabel.text = getDeparment.name
        locationLabel.text = getDeparment.location
        phoneLabel.text = getDeparment.phone_number
        descLabel.text = getDeparment.short_desc
        let imageURL = URL(fileURLWithPath: getDeparment.image_link!)
        
        print(imageURL)
        
        do {
            let imagedata: Data = try Data(contentsOf: imageURL)
            depImage.image = UIImage(data: imagedata)
        } catch  {
            print("unable to load image")
        }
    
        
        
        feedbackButton.layer.cornerRadius = 16
        feedbackButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        feedbackButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        feedbackButton.layer.masksToBounds = true

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "createRate" {
        
            let controller = segue.destination as! UINavigationController
            let vc = controller.viewControllers[0] as! CreateRateTableController
            vc.getdep_id = getDeparment.id
  
        } else {
            
            let controller = segue.destination as! ListCommentTableController
            controller.getDeparmentID = getDeparment.id
            
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return UITableView.automaticDimension
        } else {
            return tableView.estimatedRowHeight
        }
    }

}
