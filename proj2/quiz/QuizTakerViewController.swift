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
    var questOrder : [Int]?
    var quizAttempt : [Question]?
    var answered : [String]?
    var quiz : Quiz?
    
    @IBOutlet weak var Abutt: RadioButton!
    
    @IBOutlet weak var BButt: RadioButton!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var CButt: RadioButton!
    @IBOutlet weak var DButt: RadioButton!
    var correct = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        currQuest = ud.integer(forKey: "currQuest") ?? 0
        if(currQuest == 0){
            quizAttempt = []
            answered = []
        }
        currQuiz = ud.string(forKey: "currQuiz") ?? "unknownQuiz"
        print(currQuiz)
        loadquiz()
        Abutt.isSelected = false
        BButt.isSelected = false
        CButt.isSelected = false
        DButt.isSelected = false
        Abutt?.alternateButton = [BButt!, CButt!, DButt!]
        BButt?.alternateButton = [Abutt!, CButt!, DButt!]
        CButt?.alternateButton = [BButt!, Abutt!, DButt!]
        DButt?.alternateButton = [BButt!, CButt!, Abutt!]
        var timeLeft = 1800
                
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
                               
                        
            timeLeft -= 1
                        
            self.timer.text = "Time remaining: " + String(timeLeft / 60) + ":" + String(timeLeft % 60)
            if(timeLeft==0){
                timer.invalidate()
                for n in currQuest!...9 {
                answered!.append(" ")
                    DBHelper.inst.addQuizAnswer(user : ud.string(forKey: "currUser")!, name: quizName.text!, questions : quizAttempt!, answer: answered!, right: correct)
                    let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let wel = sb.instantiateViewController(withIdentifier: "LoggedIn") as! ViewController
                    present(wel, animated: true, completion: nil)
                    return
                }
                                
                            
            }
            
        }

        // Do any additional setup after loading the view.
    }
    
    
    func loadquiz(){
        
        
        if(quiz == nil){
            quiz = DBHelper.inst.getQuiz(query: currQuiz!)
        }
        if(quiz != nil){
            Abutt.isSelected = false
            BButt.isSelected = false
            CButt.isSelected = false
            DButt.isSelected = false
            if(currQuest == 0){
                questOrder = Array(0...quiz!.questions!.count)
                questOrder!.shuffle()
            }
            print(currQuest)
            quest = quiz!.questions![currQuest!]
            quizName.text = quiz!.name
            question.text = "question " + String(currQuest! + 1) + ": " + quest!.question
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
        var thisAnswer = ""
        
      
        if(Abutt.isSelected){
            thisAnswer = quest!.a
            answered!.append(quest!.a)
        }
        else if(BButt.isSelected){
            thisAnswer = quest!.b
            answered!.append(quest!.b)
        }
        else if(CButt.isSelected){
            thisAnswer = quest!.c
            answered!.append(quest!.c)
        }
        else if(DButt.isSelected){
            thisAnswer = quest!.d
            answered!.append(quest!.d)
        }
        else{
            print("You must select an answer")
            return
        }
        quizAttempt!.append(quest!)

        if(thisAnswer == quest!.correct){
            correct += 1
        }
        currQuest! += 1
        ud.setValue(currQuest, forKey: "currQuest")
        
        if(currQuest == 10){
            DBHelper.inst.addQuizAnswer(user : ud.string(forKey: "currUser")!, name: quizName.text!, questions : quizAttempt!, answer: answered!, right: correct)
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "LoggedIn") as! WelcomeViewController
            present(wel, animated: true, completion: nil)
            return
        }
        else{
            loadquiz()
        }
        
    }
    
}
