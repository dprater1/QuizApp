//
//  SignupViewController.swift
//  proj2
//
//  Created by admin on 5/10/21.
//


import UIKit
import CryptoKit


class SignupViewController: UIViewController {

    @IBOutlet weak var uName: UITextField!
    @IBOutlet weak var uPass: UITextField!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signup(_ sender: Any) {
        
        if(DBHelper.inst.userExist(query: uName.text!)){
            let alMess1 = "please try a different username"
            let alert1 = UIAlertController(title: "Username already in use", message: alMess1, preferredStyle: .alert)
            alert1.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert1, animated: true)
        }
        else if(uPass.text!.count < 5){
            let alMess = "please make sure that your password has at least 6 characters."
            let alert = UIAlertController(title: "Password too short", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }
        else{
        
            let inputString = uPass.text! + uName.text! + "423"
            let inputData = Data(inputString.utf8)
            let hashed = SHA256.hash(data: inputData)
            print(hashed)
            let dic = ["username": uName.text, "password": String(describing: hashed)] as [String : Any]
            DBHelper.inst.addNewUser(object: dic as! [String:String])
            
            //back to previous screen
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "Login") as! LoginViewController
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
