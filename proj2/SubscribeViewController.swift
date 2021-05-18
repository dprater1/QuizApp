//
//  SubscribeViewController.swift
//  proj2
//
//  Created by admin on 5/17/21.
//

import UIKit

class SubscribeViewController: UIViewController {
    var ud = UserDefaults.standard
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var ccn: UITextField!
    @IBOutlet weak var ccv: UITextField!
    @IBOutlet weak var eMonth: UITextField!
    @IBOutlet weak var eYear: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        if(name.text!.count > 2 && ccn.text!.count == 12 && ccv.text!.count == 3 && eMonth.text!.count <= 2 && eYear.text!.count == 4){
            DBHelper.inst.subscribe(query: ud.string(forKey: "currUser")!)
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "LoggedIn") as! WelcomeViewController
            present(wel, animated: true, completion: nil)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
