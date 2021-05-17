//
//  QuizRankViewController.swift
//  proj2
//
//  Created by admin on 5/17/21.
//

import UIKit

class QuizRankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ud = UserDefaults.standard
    var users  : [QuizAnswer]?
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users!.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RankTableViewCell
            
            //edit information in cell
            cell.rank.text = String(users![indexPath.row].correct) + "/10"
            cell.name.text = users![indexPath.row].user!.username
            
            return cell
        }

    @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
            users = DBHelper.inst.fetchAllQuizAnswer(quiz : ud.string(forKey: "currQuiz") ?? "")
            tableView.delegate = self
            tableView.dataSource = self
            super.viewDidLoad()
            users!.sort(by: {
                $0.correct > $1.correct
            })

         
        }
        

    }



