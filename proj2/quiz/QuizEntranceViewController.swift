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
    var currUser : User?
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        currUser = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        DBHelper.inst.getQuizAnswer(user: ud.string(forKey: "currUser") ?? "", quiz: ud.string(forKey: "currQuiz") ?? "unknownQuiz")
        takeButton.isHidden = false
        if(DBHelper.dataCheck){
            reviewButton.isHidden = false
            reviewButton.setTitle("Review best attempt", for: .normal)
            takeButton.setTitle("Retake Quiz", for: .normal)
            rankingButton.setTitle("View Rankings", for: .normal)
            rankingButton.isHidden = false
        }
        else{
            rankingButton.isHidden = true
            reviewButton.isHidden = true
            takeButton.setTitle("Take Quiz", for: .normal)
        }
        if(currUser!.quizzesLeft == 0){
            takeButton.isHidden = true
        }
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takeQuiz(_ sender: Any) {
        ud.setValue(0, forKey: "currQuest")
        let sb : UIStoryboard = UIStoryboard(name: "quiz", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "TakeQuiz") as! QuizTakerViewController
        present(wel, animated: true, completion: nil)
    }
    
    @IBAction func reviewQuiz(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "quiz", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "ReviewQuiz") as! ReviewQuizViewController
        present(wel, animated: true, completion: nil)
    }
        
    @IBAction func rankingView(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "quiz", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "QuizRank") as! QuizRankViewController
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
