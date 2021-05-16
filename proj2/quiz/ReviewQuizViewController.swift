//
//  ReviewQuizViewController.swift
//  proj2
//
//  Created by admin on 5/16/21.
//

import UIKit

class ReviewQuizViewController: UIViewController {
    let ud = UserDefaults.standard
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    @IBOutlet weak var answer4: UILabel!
    
    
    @IBOutlet weak var imageA: UIImageView!
    @IBOutlet weak var imageB: UIImageView!
    @IBOutlet weak var imageC: UIImageView!
    @IBOutlet weak var imageD: UIImageView!
    
    var currQuiz : QuizAnswer?
    var currQuest : Question?
    var questNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currQuiz = DBHelper.inst.getQuizAnswer(user: ud.string(forKey: "currUser")!, quiz: ud.string(forKey: "currQuiz")!)
        currQuest = currQuiz!.questions![questNum]
        

        // Do any additional setup after loading the view.
    }
    func changeQuestion(){
        questionLabel.text = "question " + String(questNum + 1) + currQuest!.question
        answer1.text = currQuest!.a
        answer2.text = currQuest!.b
        answer3.text = currQuest!.c
        answer4.text = currQuest!.d
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = true
        
        switch currQuiz!.answers![questNum] {
        case currQuest!.a:
            imageA.isHidden = false
            imageA.image = UIImage(contentsOfFile: "wrong")
        case currQuest!.b:
            imageB.isHidden = false
            imageB.image = UIImage(contentsOfFile: "wrong")
        case currQuest!.c:
            imageC.isHidden = false
            imageC.image = UIImage(contentsOfFile: "wrong")
        case currQuest!.d:
            imageD.isHidden = false
            imageD.image = UIImage(contentsOfFile: "wrong")
            
        default:
            print("error")
        
        }
        switch currQuest!.correct {
        case currQuest!.a:
            imageA.isHidden = false
            imageA.image = UIImage(contentsOfFile: "correct")
        case currQuest!.b:
            imageB.isHidden = false
            imageB.image = UIImage(contentsOfFile: "correct")
        case currQuest!.c:
            imageC.isHidden = false
            imageC.image = UIImage(contentsOfFile: "correct")
        case currQuest!.d:
            imageD.isHidden = false
            imageD.image = UIImage(contentsOfFile: "correct")
            
        default:
            print("error")
        
        }
    }

    @IBAction func chooseQuestion(_ sender: UISegmentedControl) {
        questNum = sender.selectedSegmentIndex
        changeQuestion()
        
        
    }
}
