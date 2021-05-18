//
//  LoginViewController.swift
//  proj2
//
//  Created by admin on 5/10/21.
//

import UIKit
import CryptoKit
import FBSDKLoginKit


class LoginViewController: UIViewController {
    let ud = UserDefaults.standard
    static let loginManager: LoginManager = LoginManager()
    
    
    
    
    @IBOutlet weak var uName: UITextField!
    @IBOutlet weak var uPass: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
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
        if(DBHelper.inst.validatePass(uName: uName.text!, uPass: String(describing: hashed))){
            ud.setValue(uName.text, forKey: "currUser")
            if(remSwitch.isOn){
                
                ud.setValue(uName.text, forKey: "uName")
                ud.setValue(true, forKey: "rem")
                ud.setValue(uPass.text, forKey: "uPass")
                
            }
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if(uName.text! == "Admin"){
                
                let wel = sb.instantiateViewController(withIdentifier: "Admin") as! AdminViewController
                present(wel, animated: true, completion: nil)
            }
            else{
                if ud.value(forKey: "currUserBlocked")! as! Bool {
                    let Alert = UIAlertController(title: "Blocked", message: "Contact an admin to unblock your account", preferredStyle: .alert)
                    Alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    present(Alert, animated: true, completion: nil)
                } else {
                print("username and password matched")
                ud.setValue(uName.text, forKey: "currUser")
                
                let wel = sb.instantiateViewController(withIdentifier: "LoggedIn") as! WelcomeViewController
                present(wel, animated: true, completion: nil)
                }
            }
        }
        else{
            let altit = "Incorrect username or password."
            let alMess = "Please try again"
            let alert = UIAlertController(title: altit, message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
                
                
            }
    }
    @IBAction func fbButton(_ sender: Any) {
    if AccessToken.current == nil {
               //Session is not active
               
        LoginViewController.loginManager.logIn(permissions: ["public_profile","email"], from: self, handler: { result,error   in
            if error != nil {
            } else if result!.isCancelled {
          print("login cancelled by user")
            } else {
                print("login successfully")
                let token = result?.token?.tokenString
                let req = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: token, version: nil, httpMethod: .get)
                req.start {(connection,result,error) in
                    let fbDetails = result as! NSDictionary
                    let email = fbDetails.value(forKey: "email")! as! String
                    let emailArr = email.components(separatedBy: "@")
                    let user = ["username" : emailArr[0]]
                    self.ud.setValue(emailArr[0], forKey: "currUser")
                    let usr = DBHelper.inst.fetchUser(query: emailArr[0])
                    if DBHelper.dataCheck {
                        if usr!.isBlocked {
                            let Alert = UIAlertController(title: "Blocked", message: "Please contact an admin to unblock your account", preferredStyle: .alert)
                            Alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                            self.present(Alert, animated: true, completion: nil)
                        } else {
                            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let wel = sb.instantiateViewController(withIdentifier: "LoggedIn") as! WelcomeViewController
                            self.present(wel, animated: true, completion: nil)
                        }
                    } else {
                        DBHelper.inst.addNewUser(object: user)
                        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let wel = sb.instantiateViewController(withIdentifier: "LoggedIn") as! WelcomeViewController
                        self.present(wel, animated: true, completion: nil)
                    }
                }
            }
        })
           } else {
            print("already logged in")
            LoginViewController.loginManager.logOut()
            print("User logout succesfully")
           }
    }
    
}
