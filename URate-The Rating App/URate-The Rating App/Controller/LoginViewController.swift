
import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //variable to store email
    @IBOutlet weak var email: UITextField!
    //variable to store password
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the firebase refrence
        ref = Database.database().reference()
    }
    
    @IBAction func login(_ sender: Any) {
        login()
    }
    
    func login(){
        
        guard let emailAdd = email.text else{
            print("Email Missing")
            return
        }
        
        guard let pass = password.text else{
            print("Password Missing")
            return
        }
        
        //logIn the user with the firebase
        Auth.auth().signIn(withEmail: emailAdd, password: pass) { (user, error) in
            if error != nil{
                print(error!)
                return
            }
            
            //Successfully logged In
            self.performSegue(withIdentifier: "loginLanding", sender: self)
        }
    }
}
