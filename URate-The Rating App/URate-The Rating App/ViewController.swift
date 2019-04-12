import UIKit
import Firebase

class ViewController: UIViewController {
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //database handler
    var databaseHandle: DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the firebase refrence
        ref = Database.database().reference()
        
    }
}

