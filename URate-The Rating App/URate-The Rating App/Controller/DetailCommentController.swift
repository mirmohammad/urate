//
//  DetailCommentController.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-27.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit

class DetailCommentController: UIViewController {
    
    var getUsername:String!
    var getComment:String!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var usernameVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = getUsername
        commentLabel.text = getComment
        
        //Estimate height of comment
        
        commentView.layer.cornerRadius = 12
        commentView.layer.masksToBounds = true
        commentView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        commentLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        usernameVIew.layer.cornerRadius = 12
        usernameVIew.layer.masksToBounds = true
        usernameVIew.backgroundColor = #colorLiteral(red: 0.00266837189, green: 0.3425685763, blue: 0.488183856, alpha: 1)
        usernameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        

        // Do any additional setup after loading the view.
    }
    
}
