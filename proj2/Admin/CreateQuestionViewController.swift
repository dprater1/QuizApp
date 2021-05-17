//
//  CreateQuestionViewController.swift
//  proj2
//
//  Created by admin on 5/12/21.
//

import UIKit

class CreateQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passTitle : String = ""
    var questions : [String] = []
    static var questionObj : [Question] = []
    //number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    //cell for row at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.8, shadowPathInset: (dx: 16, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        //edit information in cell
        cell.textLabel?.text = questions[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func doesQuestionExist(question : String) -> Bool {
        for data in questions {
            if data == question {
                return true
            } else {
                return false
            }
        }
        return false
    }
    //did select row at indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "questions") as QuestionAnswersViewController
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        viewController.passQuestion = questions[indexPath.row]
        self.present(viewController, animated: true, completion: nil)
        print(CreateQuestionViewController.questionObj)
        currentCell.imageView?.image = UIImage(systemName: "checkmark")
        currentCell.isUserInteractionEnabled = false
    }
    
    //delete questions
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
            var counter = 0
            for data in CreateQuestionViewController.questionObj {
                if data.question.contains(currentCell.textLabel!.text!){
                    currentCell.isUserInteractionEnabled = true
                    print(CreateQuestionViewController.questionObj)
                    print("deleting object at index ... \(counter)")
                    CreateQuestionViewController.questionObj.remove(at: counter)
                }
                counter += 1
            }
            currentCell.imageView?.image = UIImage(systemName: "questionmark")
            questions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newQuestion(_ sender: Any) {
        let textAlertView = UIAlertController(title: "Create Question", message: "Enter question", preferredStyle: .alert)
        
        textAlertView.addTextField(configurationHandler: nil) //textFields[0]
        //can add more textFields, increment index per field
        
        textAlertView.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            //checks if question is a certain length
            if textAlertView.textFields![0].text!.count <= 1 {
                let AlertView = UIAlertController(title: "Not a valid  question.", message: "Please enter a valid question", preferredStyle: .alert)
                AlertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(AlertView, animated: true, completion: nil)
            } else {
                if self.doesQuestionExist(question: textAlertView.textFields![0].text!){
                    let Alert = UIAlertController(title: "Question Exists", message: "Make sure you dont write the same question more than once", preferredStyle: .alert)
                    Alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(Alert, animated: true, completion: nil)
                } else {
                    self.questions.append(textAlertView.textFields![0].text!)
                    self.tableView.reloadData()
                }
            }
        }))
        textAlertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(textAlertView, animated: true, completion: nil)
        
    }
    func verifyCompleteQuestions() -> Bool {
        var count = -1
        for cell in self.tableView.visibleCells {
            count += 1
            if cell.imageView?.image == UIImage(systemName: "checkmark") {
                print("check")
            } else {
                print("notcheck")
                return false
            }
        }
        if count == -1 {
            print("none exist")
            return false
        } else {
            print("all check")
            return true
        }
    }
    @IBAction func deleteArray(_ sender: Any) {
        CreateQuestionViewController.questionObj.removeAll()
    }
    
    @IBAction func submitQuiz(_ sender: Any) {
        if questions.count < 10 {
            let Alert = UIAlertController(title: "Not enough questions", message: "Please enter at least 10 questions", preferredStyle: .alert)
            Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(Alert, animated: true, completion: nil)
        } else {
        if verifyCompleteQuestions() {
            let Alert = UIAlertController(title: "Quiz Complete", message: "Are you sure you want to submit Quiz?", preferredStyle: .alert)
            Alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                print("submitting quiz...")
                DBHelper.inst.addQuiz(title: self.passTitle, question : CreateQuestionViewController.questionObj)
                print("resetting quiz template...")
                CreateQuestionViewController.questionObj.removeAll()
                let Alert1 = UIAlertController(title: "Quiz Submitted", message: "Moving back to admin page!", preferredStyle: .alert)
                Alert1.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Admin") as! AdminViewController
                    self.present(vc, animated: true, completion: nil)
                    
                    }))
                self.present(Alert1, animated: true, completion: nil)
                
            }))
            Alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(Alert, animated: true)
            } else {
            let Alert = UIAlertController(title: "Incomplete Quiz", message: "Please submit all and valid questions!", preferredStyle: .alert)
            Alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(Alert, animated: true)
        }
    }
        
    }
    
}

