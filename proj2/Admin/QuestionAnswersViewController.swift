//
//  QuestionAnswersViewController.swift
//  proj2
//
//  Created by Bruno Gomez on 5/13/21.
//

import UIKit

class QuestionAnswersViewController: UIViewController {
    
    
    var passQuestion = ""
    var answers : [String] = []
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var correctAnswer: UITextField!
    @IBOutlet weak var wrongAnswer1: UITextField!
    @IBOutlet weak var wrongAnswer2: UITextField!
    @IBOutlet weak var wrongAnswer3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = passQuestion
        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitAnswers(_ sender: Any) {
        if correctAnswer.text!.count <= 2 || wrongAnswer1.text!.count <= 2 || wrongAnswer2.text!.count <= 2 ||
            wrongAnswer3.text!.count <= 2 {
            let Alert = UIAlertController(title: "Invalid Answers", message: "Please make sure all answers are valid", preferredStyle: .alert)
            Alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(Alert, animated: true, completion: nil)
        } else {
            let Alert = UIAlertController(title: "Valid Answers!", message: "Are you sure you want to submit these answers?", preferredStyle: .alert)
            Alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] _ in
                answers.append(correctAnswer.text!)
                answers.append(wrongAnswer1.text!)
                answers.append(wrongAnswer2.text!)
                answers.append(wrongAnswer3.text!)
                answers.shuffle()
                
                let questionObj = Question(question : question.text!,a: answers[0], b: answers[1], c: answers[2], d: answers[3], correct: correctAnswer.text!)
                
                CreateQuestionViewController.questionObj.append(questionObj)
                print(CreateQuestionViewController.questionObj)
                self.dismiss(animated: true, completion: nil)
            }))
            Alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            present(Alert, animated: true)
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
