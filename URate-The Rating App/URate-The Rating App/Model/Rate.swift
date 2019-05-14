//
//  Rate.swift
//  URate-The Rating App
//
//  Created by William Ching on 2019-04-27.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit

class Rate: NSObject {
    
    var user_id:String?
    var dep_id:String?
    var comment:String?
    var rate:Int?
    var user_name: String?
    
    init(userID: String, depID: String, comment: String, rate: Int, userName: String) {
        self.user_id = userID
        self.dep_id = depID
        self.comment = comment
        self.rate = rate
        self.user_name = userName
    }

}
