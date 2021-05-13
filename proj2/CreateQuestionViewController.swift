//
//  CreateQuestionViewController.swift
//  proj2
//
//  Created by admin on 5/12/21.
//

import UIKit

class CreateQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var questions : [String] = []
    //number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    //cell for row at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //edit information in cell
        cell.textLabel?.text = questions[indexPath.row]
        return cell
    }
    //did select row at indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me! ", indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            questions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
                self.questions.append(textAlertView.textFields![0].text!)
                self.tableView.reloadData()
            }
        }))
        textAlertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(textAlertView, animated: true, completion: nil)
        
    }
}

