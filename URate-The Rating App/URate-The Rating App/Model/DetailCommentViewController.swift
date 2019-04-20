//
//  DetailCommentViewController.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-19.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit

class DetailCommentViewController: UIViewController {

    var getComment:String?
    var getUsername:String?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usercontainer: UIView!
    
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = getUsername
        commentLabel.text = getComment
        
        //Estimate height of comment
        
        
        usercontainer.layer.cornerRadius = 12
        usercontainer.layer.masksToBounds = true
        usercontainer.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        usernameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        container.layer.cornerRadius = 12
        container.layer.masksToBounds = true
        container.backgroundColor = #colorLiteral(red: 0.00266837189, green: 0.3425685763, blue: 0.488183856, alpha: 1)
        commentLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
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
