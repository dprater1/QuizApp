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
    
    @IBOutlet weak var unansweredOutlet: UILabel!
    var currQuiz : QuizAnswer?
    var currQuest : Question?
    var questNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answer1.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.6, shadowPathInset: (dx: 16, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        answer2.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.6, shadowPathInset: (dx: 16, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        answer3.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.6, shadowPathInset: (dx: 16, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        answer4.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.6, shadowPathInset: (dx: 16, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        
        currQuiz = DBHelper.inst.getQuizAnswer(user: ud.string(forKey: "currUser")!, quiz: ud.string(forKey: "currQuiz")!)
        changeQuestion()
        

        // Do any additional setup after loading the view.
    }
    func changeQuestion(){
        currQuest = currQuiz!.questions![questNum]
        questionLabel.text = "question " + String(questNum + 1) + ": "  + currQuest!.question
        answer1.text = currQuest!.a
        answer2.text = currQuest!.b
        answer3.text = currQuest!.c
        answer4.text = currQuest!.d
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = true
        unansweredOutlet.isHidden = true
        print(currQuiz!.answers![questNum])
        switch currQuiz!.answers![questNum] {
        case currQuest!.a:
            print("a")
            imageA.isHidden = false
            imageA.image = UIImage(named: "wrong")
        case currQuest!.b:
            print("b")
            imageB.isHidden = false
            imageB.image = UIImage(named: "wrong")
        case currQuest!.c:
            print("c")
            imageC.isHidden = false
            imageC.image = UIImage(named: "wrong")
        case currQuest!.d:
            print("d")
            imageD.isHidden = false
            imageD.image = UIImage(named: "wrong")
        case " ":
            unansweredOutlet.isHidden = false
            
        default:
            print("error")
        
        }
        switch currQuest!.correct {
        case currQuest!.a:
            imageA.isHidden = false
            imageA.image = UIImage(named: "correct")
        case currQuest!.b:
            imageB.isHidden = false
            imageB.image = UIImage(named: "correct")
        case currQuest!.c:
            imageC.isHidden = false
            imageC.image = UIImage(named: "correct")
        case currQuest!.d:
            imageD.isHidden = false
            imageD.image = UIImage(named: "correct")
            
        default:
            print("error")
        
        }
    }

    @IBAction func chooseQuestion(_ sender: UISegmentedControl) {
        questNum = sender.selectedSegmentIndex
        changeQuestion()
        
        
    }
}
