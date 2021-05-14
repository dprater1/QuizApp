//
//  QuizTakerViewController.swift
//  proj2
//
//  Created by admin on 5/14/21.
//

import UIKit

class QuizTakerViewController: UIViewController {
    let ud = UserDefaults.standard
    
    @IBOutlet weak var quizName: UILabel!
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    @IBOutlet weak var answer4: UILabel!
    var currQuiz : String?
    var currQuest : Int?
    var quest : Question?
    
    @IBOutlet weak var Abutt: RadioButton!
    
    @IBOutlet weak var BButt: RadioButton!
    
    @IBOutlet weak var CButt: RadioButton!
    @IBOutlet weak var DButt: RadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var currQuest = ud.integer(forKey: "currQuest") ?? 0
        currQuiz = ud.string(forKey: "currQuiz") ?? "unknownQuiz"
        loadquiz()
        Abutt.isSelected = false
        BButt.isSelected = false
        CButt.isSelected = false
        DButt.isSelected = false
        Abutt?.alternateButton = [BButt!, CButt!, DButt!]
        BButt?.alternateButton = [Abutt!, CButt!, DButt!]
        CButt?.alternateButton = [BButt!, Abutt!, DButt!]
        DButt?.alternateButton = [BButt!, CButt!, Abutt!]

        // Do any additional setup after loading the view.
    }
    
    
    func loadquiz(){
        
        let quiz = DBHelper.inst.getQuiz(query: currQuiz!)
        if(quiz != nil){
            quest = quiz!.questions![currQuest!]
            quizName.text = quiz!.name
            question.text = "question " + String(currQuest! + 1) + quest!.question
            answer1.text = quest!.a
            answer2.text = quest!.b
            answer3.text = quest!.c
            answer4.text = quest!.d
        }
        else{
            print("quiz does not exist")
        }
    }

   
    @IBAction func submitQuestion(_ sender: Any) {
        
        ud.setValue(currQuest! + 1, forKey: "currQuest")
    }
    
}
