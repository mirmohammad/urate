
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
            //self.createAlert(title: "ERROR:", message: "Email not exist!")
            return
        }
        guard let pass = password.text else{
            //self.createAlert(title: "ERROR:", message: "Enter your password!")
            return
        }
        
        //logIn the user with the firebase
        Auth.auth().signIn(withEmail: emailAdd, password: pass) { (user, error) in
            if user != nil{
                //Successfully logged In
                 self.performSegue(withIdentifier: "loginLanding", sender: self)
                //Not entering the email
            }else if emailAdd.isEmpty {
                self.createAlert(title: "ERROR:", message: "Enter your email!")
            }else{
                //not registered email
                self.createAlert(title: "ERROR:", message: "Email not exist!")
            }
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
