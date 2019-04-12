# URate

The basic application that allows user to rate the various services of LaSalle college. 

###### Basic guidlines for the setup

1) Take the checkout of the project
2) Navigate to Main folder and double click on URate-The Rating App.xcworkspace (For the image refer to project guide images image 1)
3) Create your own branches and start contributing

> Happy Coding



###### Basic code for reading the data

> Check project for model class Department.swift
> If you are not yet granted the database access please refer to images folder for the structure of realtime database

```
import UIKit
import Firebase

class ViewController: UIViewController {
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //database handler
    var databaseHandle: DatabaseHandle?
    
    //this variable stores the departments
    var depArray = [Department]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the firebase refrence
        ref = Database.database().reference()
        
        //Retreive the departments and listen to the changes
        let depRef = ref?.child("Departments").observe(.value, with: { (snapshot) in
            guard let depDictionary = snapshot.value as? [String:[String : Any]] else{
                return
            }
            
            for(_,val) in depDictionary{
                let newObj = Department()
                newObj.id = val["id"] as! String
                newObj.location = val["location"] as! String
                newObj.long_desc = val["long_desc"] as! String
                newObj.short_desc = val["short_desc"] as! String
                newObj.name = val["name"] as! String
                newObj.phone_number = val["phone_number"] as! String
                newObj.image_link = val["image_link"] as! String
                print(newObj.name)
                self.depArray.append(newObj)
            }
        })
    }

```



