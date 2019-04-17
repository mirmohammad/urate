
import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //link to user first name
    @IBOutlet weak var firstName: UITextField!
    //link to user last name
    @IBOutlet weak var lastName: UITextField!
    //link to user email
    @IBOutlet weak var email: UITextField!
    //link to user password
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the firebase refrence
        ref = Database.database().reference()
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        signUp()
    }
    
    func signUp(){
        guard let fName = firstName.text else{
            print("Missing First Name")
            return
        }
        
        guard let lName = lastName.text else {
            print("Missing Last Name")
            return
        }
        
        guard let emailAdd = email.text else {
            print("Missing email")
            return
        }
        
        guard let pass = password.text else {
            print("Missing Password")
            return
        }
        
        Auth.auth().createUser(withEmail: emailAdd, password: pass) { (user, error) in
            if error != nil{
                print(error!)
                return
            }
            guard let uId = Auth.auth().currentUser?.uid else{
                return
            }
            // Dictionary to save the user values in database
            let values = ["firstName":fName,
                          "lastName":lName,
                          "email": emailAdd]
            //User is authenticated
            self.ref?.child("users").child(uId).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil{
                    print(error!)
                    return
                }
            })
            //user is registered , go to home screen
            self.performSegue(withIdentifier: "landingView", sender: self)
        }
    }
}
