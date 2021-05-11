//
//  AdminViewController.swift
//  proj2
//
//  Created by admin on 5/11/21.
//

import UIKit

class AdminViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Access(_ sender: Any) {
        if DBHelper.inst.userExist(query: username.text!) {
            DBHelper.inst.changeAccess(query: username.text!)
        } else if username.text == nil {
            print("please enter a username")
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
