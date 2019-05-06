import UIKit
import Firebase

class LandingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Firebase refrence variable
    var ref: DatabaseReference?
    
    //database handler
    var databaseHandle: DatabaseHandle?
    
    //this variable stores the departments
    var depArray = [Department]()
    
    @IBOutlet weak var tableView: UITableView!
    
    //Show left view Menu
    @IBAction func MenuTapped(_ sender: UIBarButtonItem) {
    NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departmentCell")
        cell?.textLabel?.text = depArray[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
         getDepartments()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showInviteFriends),
                                               name: NSNotification.Name("ShowInviteFriends"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showSignIn),
                                               name: NSNotification.Name("ShowSignIn"),
                                               object: nil)
    }
    
    //Navigate to invitefriends view
    @objc func showInviteFriends() {
        performSegue(withIdentifier: "ShowInviteFriends", sender: nil)
    }
    
    @objc func showSignIn() {
        performSegue(withIdentifier: "ShowSignIn", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDepartmentDetails"){
        let controller = segue.destination as! DeparmentViewController

        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("No item selected")
        }
        controller.getDeparment = depArray[indexPath.row]
        //print(controller.getDeparmentID)
        }
    }
    
    
    
    
    func getDepartments(){
    
        //set the firebase refrence
        ref = Database.database().reference()
    
            //Retreive the departments and listen to the changes
            self.ref?.child("Departments").observe(.value, with: { (snapshot) in
                guard let depDictionary = snapshot.value as? [String:[String : Any]] else{
                    return
                }
                
                for(_,val) in depDictionary{
                    let newObj = Department()
                    newObj.id = val["id"] as? String
                    newObj.location = val["location"] as? String
                    newObj.long_desc = val["long_desc"] as? String
                    newObj.short_desc = val["short_desc"] as? String
                    newObj.name = val["name"] as? String
                    newObj.phone_number = val["phone_number"] as? String
                    newObj.image_link = val["image_link"] as? String
                    self.depArray.append(newObj)
                }
                
                // this reload method was added as data was populated later but numberOfRowsInSection was called later
                //reloading tableview
                self.tableView.reloadData()
            })
        }
        
        
    }
