//
//  QuizEntranceViewController.swift
//  proj2
//
//  Created by admin on 5/16/21.
//

import UIKit

class QuizEntranceViewController: UIViewController {
    let ud = UserDefaults.standard
    var currQuizAns : QuizAnswer?
    
    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        DBHelper.inst.getQuizAnswer(user: ud.string(forKey: "currUser") ?? "", quiz: ud.string(forKey: "currQuiz") ?? "unknownQuiz")
        if(DBHelper.dataCheck){
            reviewButton.isHidden = false
            reviewButton.setTitle("Review best attempt", for: .normal)
            takeButton.setTitle("Retake Quiz", for: .normal)
        }
        else{
            reviewButton.isHidden = true
            takeButton.setTitle("Take Quiz", for: .normal)
        }
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takeQuiz(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "quiz", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "TakeQuiz") as! QuizTakerViewController
        present(wel, animated: true, completion: nil)
    }
    
    @IBAction func reviewQuiz(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "quiz", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "ReviewQuiz") as! ReviewQuizViewController
        present(wel, animated: true, completion: nil)
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
