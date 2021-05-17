//
//  RankingViewController.swift
//  proj2
//
//  Created by Bruno Gomez on 5/16/21.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users = DBHelper.inst.fetchAllUser()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //edit information in cell
        cell.detailTextLabel?.text = String(users[indexPath.row].correctAnswered)
        cell.textLabel?.text = users[indexPath.row].username
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("1st place gets 30 days")
            users[indexPath.row].quizzesLeft = -1
        case 1:
            print("2nd place gets 30 days")
            users[indexPath.row].quizzesLeft = -1
        case 2:
            print("3rd place gets 30 days")
            users[indexPath.row].quizzesLeft = -1
        default:
            print("you're not special")
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        users.sort(by: {
            $0.correctAnswered > $1.correctAnswered
        })

        // Do any additional setup after loading the view.
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
