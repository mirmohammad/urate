
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
            if user != nil{
                //user is registered , go to home screen
                self.performSegue(withIdentifier: "landingView", sender: self)
                //check the firstname
            }else if fName.isEmpty {
                self.createAlert(title: "ERROR:", message: "Please enter your name!")
                //check the last name
            }else if lName.isEmpty {
                self.createAlert(title: "ERROR:", message: "Please enter your last name!")
                //check the email address
            }else if emailAdd.isEmpty {
                self.createAlert(title: "ERROR:", message: "Please enter your email!")
                //check the password
            }else if pass.isEmpty {
                self.createAlert(title: "ERROR:", message: "Please enter your password!")
                //if not registered successfully
            }else{
                self.createAlert(title: "ERROR:", message: "Email not exist!")
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
        }
    }
    
    
    func createAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true,completion: nil)
    }
}
