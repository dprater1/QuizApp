//
//  ForumViewController.swift
//  proj2
//
//  Created by admin on 5/11/21.
//

import UIKit

class ForumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let topics = ["iOS", "General", "Java"]
    let ud = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topics.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ForumTableViewCell
        
        cell.ForumTitle.text = topics[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ud.setValue(topics[indexPath.item], forKey: "currForum")
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "Thread") as! ThreadTableViewController
        present(wel, animated: true, completion: nil)
        
        
        
    }


}
