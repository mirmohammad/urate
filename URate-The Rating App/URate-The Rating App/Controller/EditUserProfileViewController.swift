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
    //var userImageUrl = String()
    
    //MARK: UI layout variables
    @IBOutlet weak var userProfileImageView: UIImageView!
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
        
        //add action gesture to the imageView
        userProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        
    }
    
    
    
    //MARK: action 

    @IBAction func saveEditClicked(_ sender: Any) {
        switch inEditMode{
        case true:
            //updateUser()
            writeImageToFirebase()
            editMode(enabled: false)
        case false:
            editMode(enabled: true)
        }
    }
}

//MARK: tableView Extension
extension EditUserProfileViewController: UITextViewDelegate, UITableViewDataSource{
   //this extension for tableViewController
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
            let imageUrl = value?["user_image_url"] as? String ?? "user_icon"
            self.nameTextField.text = userFirstName + " " + userLastName
            self.emailTextField.text = email
            self.phoneTextField.text = phone
            self.firstNameTextField.text = userFirstName
            self.lastNameTextField.text = userLastName
           
            if let url = NSURL(string: imageUrl) { if let data = NSData(contentsOf: url as URL) { self.userProfileImageView.image = UIImage(data: data as Data) } }
            
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
        userProfileImageView.isUserInteractionEnabled = enable
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
        
        self.ref.child("Rate").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
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
    
    func updateUser(imgUrl: String){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //print("updateUser func")
        //writeImageToFirebase()
        let usersRef = ref.child("users").child(uid)
        let userFirstName = firstNameTextField.text
        let userLastName = lastNameTextField.text
        let email = self.emailTextField.text
        let phone = self.phoneTextField.text
        
        let values = ["email": email, "firstName": userFirstName, "lastName": userLastName, "phone": phone, "user_image_url": imgUrl]
        usersRef.updateChildValues(values){
            (err, ref) in
           if err != nil{
               print(err!)
                return
           }
        }
    }
    
    
}

//MARK: image handler
extension EditUserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    //this extension is to handle user image
    
    @objc func handleSelectProfileImageView(){
        //action performed when user tap touch the user image
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true // allow user to edit his image before uploading it
        present(picker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // opens the image picker controller to show the image library
        var selectedImageFromPicker = UIImage()
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
             //print(editedImage.size)
            selectedImageFromPicker = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                print(originalImage.size)
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker as? UIImage{
            userProfileImageView.image = selectedImage
        }
        
         dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // if user cancels and didn't choose an image from the image library
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
    func writeImageToFirebase(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //the following code is to upload user_image to firebase
        //let imageName = NSUUID().uuidString // give the image file a rundom name
        
        //put the image in the data store in the directory profile_images
        let storageRef = Storage.storage().reference().child("profile_images").child("\(uid).png")
        
        if let profileImageUrl = self.userProfileImageView.image, let  uploadData = self.userProfileImageView.image!.pngData() {
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil, metadata != nil {
                    print(error ?? "")
                    return
                }
                
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    //print("this is the \(url)")
                    if let profileImageUrl = url?.absoluteString {
                        self.updateUser(imgUrl: profileImageUrl)
                        //self.setUserImageUrl(url: profileImageUrl)
                        //print("this is the userImageUrl \(self.userImageUrl)")
                    }
                })
            })
        }
    }//end of writeImageToFirebase
//    func setUserImageUrl(url: String){
//        userImageUrl = url
//        print("setUserImageUrl \(url)")
//    }//end of setUserImageUrl
}//end of extension
