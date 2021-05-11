//
//  LoginViewController.swift
//  proj2
//
//  Created by admin on 5/10/21.
//

import UIKit
import CryptoKit



class LoginViewController: UIViewController {
    let ud = UserDefaults.standard
    
    
    
    @IBOutlet weak var uName: UITextField!
    @IBOutlet weak var uPass: UITextField!
    @IBOutlet weak var remSwitch: UISwitch!
    override func viewDidLoad() {
        if ud.bool(forKey: "rem"){
            uName.text = ud.string(forKey: "uName")
            uPass.text = ud.string(forKey: "uPass")
            remSwitch.isOn = true
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func remSwitched(_ sender: Any) {
        if(remSwitch.isOn){
            
            ud.setValue(uName.text, forKey: "uName")
            ud.setValue(true, forKey: "rem")
            ud.setValue(uPass.text, forKey: "uPass")
            
        }
        else{
            ud.removeObject(forKey: "uName")
            ud.removeObject(forKey: "uPass")
            ud.setValue(false, forKey: "rem")
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let inputString = uPass.text! + uName.text! + "423"
        
        let inputData = Data(inputString.utf8)
        let hashed = SHA256.hash(data: inputData)
        //print(hashed)
        if (uName.text! == "Admin" && uPass.text! == "Pass123"){
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "LoggedIn") as! ViewController
            present(wel, animated: true, completion: nil)
        }
        else if(DBHelper.inst.validatePass(uName: uName.text!, uPass: String(describing: hashed))){
                
                print("username and password matched")
                ud.setValue(uName.text, forKey: "currUser")
                let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let wel = sb.instantiateViewController(withIdentifier: "LoggedIn") as! ViewController
                present(wel, animated: true, completion: nil)
            }
            else{
                let altit = "Incorrect username or password."
                let alMess = "Please try again"
                let alert = UIAlertController(title: altit, message: alMess, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
                
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
