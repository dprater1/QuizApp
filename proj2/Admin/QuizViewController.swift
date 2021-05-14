//
//  QuizViewController.swift
//  proj2
//
//  Created by admin on 5/12/21.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var quizTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CreateQuestionViewController {
            let vc = segue.destination as? CreateQuestionViewController
            vc?.passTitle = quizTitle.text!
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "questions" {
            if quizTitle?.text == nil {
                let Alert = UIAlertController(title: "Invalid Title", message: "Enter a title longer than 2 characters", preferredStyle: .alert)
                Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(Alert, animated: true, completion: nil)
                return false
            }
            if quizTitle.text!.count <= 1 {
                let Alert = UIAlertController(title: "Invalid Title", message: "Enter a title longer than 2 characters", preferredStyle: .alert)
                Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(Alert, animated: true, completion: nil)
                return false
            } else {
                return true
            }
        }
        return true
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
