//
//  AccessViewController.swift
//  proj2
//
//  Created by Bruno Gomez on 5/13/21.
//

import UIKit

class AccessViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeAccess(_ sender: Any) {
        if username.text!.count <= 2 {
            let Alert = UIAlertController(title: "Incorrect User", message: "User must be 2 characters or more", preferredStyle: .alert)
            Alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(Alert, animated: true, completion: nil)
        } else {
            if DBHelper.inst.userExist(query: username.text!) {
                if DBHelper.inst.changeAccess(query: username.text!) {
                    let Alert = UIAlertController(title: "Blocked!", message: "\(username.text!) is blocked!", preferredStyle: .alert)
                    Alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    present(Alert, animated: true, completion: nil)
                } else {
                    let Alert = UIAlertController(title: "Unblocked!", message: "\(username.text!) is unblocked!", preferredStyle: .alert)
                    Alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    present(Alert, animated: true, completion: nil)
                }
            } else {
                let Alert = UIAlertController(title: "No Such User", message: "User does not exist", preferredStyle: .alert)
                Alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(Alert, animated: true, completion: nil)
            }
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
