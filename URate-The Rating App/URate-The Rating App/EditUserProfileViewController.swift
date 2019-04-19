//
//  EditUserProfileViewController.swift
//  URate-The Rating App
//
//  Created by Ahmed Ghareeb on 2019-04-12.
//  Copyright © 2019 Sahil Gogna. All rights reserved.
//

import UIKit
import Firebase

class EditUserProfileViewController: UIViewController {
    //MARK: variables
    var ref: DatabaseReference!
    var inEditMode:Bool = false
    //MARK: UI variables

    @IBOutlet weak var editSaveBtn: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    //MARK: Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        getUserData()
        editMode(enabled: false)
    }
    
    //MARK: functions
    func getUserData(){
       // guard
            let uid = "JmLVLm37zJSo9HS3tgWP0LdHqSi1"//Auth.auth().currentUser?.uid else { return }
        print(uid)
        self.ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let userFirstName = value?["firstName"] as? String ?? "name"
            let userLastName = value?["lastName"] as? String ?? "name"
            let email = value?["email"] as? String ?? "email"
            //let phone = value?["phone"] as? String ?? "phone"
            self.nameTextField.text = userFirstName + " " + userLastName
            self.emailTextField.text = email
            //phoneTextField.text = phone
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func editMode(enabled enable:Bool){
        nameTextField.isEnabled = enable
        emailTextField.isEnabled = enable
        phoneTextField.isEnabled = enable
        inEditMode = enable
        
        if enable == true{
            editSaveBtn.setTitle("Save", for: .normal)
        }else{
            editSaveBtn.setTitle("Edit", for: .normal)
        }
        
    }
    
    //MARK: action 

    @IBAction func saveEditClicked(_ sender: Any) {
        switch inEditMode{
        case true:
            editMode(enabled: false)
        case false:
            editMode(enabled: true)
        }
    }
}
