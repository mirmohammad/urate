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
    var userComments = [String]()
    //MARK: UI variables

    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var editSaveBtn: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    //MARK: Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        getUserPosts()
        getUserData()
        
        editMode(enabled: false)
        
        commentsTableView.delegate = self as? UITableViewDelegate
        commentsTableView.dataSource = self //as? UITableViewDataSource
    }
    
    
    //MARK: action 

    @IBAction func saveEditClicked(_ sender: Any) {
        switch inEditMode{
        case true:
            updateUser()
            editMode(enabled: false)
        case false:
            editMode(enabled: true)
        }
    }
}

extension EditUserProfileViewController: UITextViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell")
        
        
        cell?.textLabel?.text = userComments[indexPath.row]
        
        return cell!
    }

}

extension EditUserProfileViewController{
    //MARK: functions
    func getUserData(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //"JmLVLm37zJSo9HS3tgWP0LdHqSi1"//
        print(uid)
        self.ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let userFirstName = value?["firstName"] as? String ?? "N/A"
            let userLastName = value?["lastName"] as? String ?? "N/A"
            let email = value?["email"] as? String ?? "N/A"
            let phone = value?["phone"] as? String ?? "N/A"
            self.nameTextField.text = userFirstName + " " + userLastName
            self.emailTextField.text = email
            self.phoneTextField.text = phone
            
            self.firstNameTextField.text = userFirstName
            self.lastNameTextField.text = userLastName
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func editMode(enabled enable:Bool){
        nameTextField.isEnabled = enable
        emailTextField.isEnabled = enable
        phoneTextField.isEnabled = enable
        firstNameTextField.isEnabled = enable
        lastNameTextField.isEnabled = enable
        
        inEditMode = enable
        
        if enable == true{
            editSaveBtn.setTitle("Save", for: .normal)
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            firstNameLabel.isHidden = false
            lastNameLabel.isHidden = false
        }else{
            editSaveBtn.setTitle("Edit", for: .normal)
            firstNameTextField.isHidden = true
            lastNameTextField.isHidden = true
            firstNameLabel.isHidden = true
            lastNameLabel.isHidden = true
            
        }
        
    }
    
    func getUserPosts(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //"JmLVLm37zJSo9HS3tgWP0LdHqSi1"//
        //print(uid)
        self.ref.child("Rate").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            //print(snapshot.children.nextObject())
            let values = snapshot.value as? NSDictionary
            
            for rates in values!{
               let rate = rates.value as? NSDictionary
                
                if rate!["user_id"] as! String == uid {
                self.userComments.append(rate!["comment"] as? String ?? "comment")
               }
               
            }
            print(self.userComments)
            self.commentsTableView.reloadData()
        }) { (error) in
            print("EROOOOOOOOOOOORRR" + error.localizedDescription)
        }
        
    }
    
    func updateUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let usersRef = ref.child("users").child(uid)
        let userFirstName = firstNameTextField.text
        let userLastName = lastNameTextField.text
        let email = self.emailTextField.text
        let phone = self.phoneTextField.text
        let values = ["email": email, "firstName": userFirstName, "lastName": userLastName, "phone": phone  ]
        usersRef.updateChildValues(values){
            (err, ref) in
           if err != nil{
               print(err!)
                return
           }
        }
    }
}
