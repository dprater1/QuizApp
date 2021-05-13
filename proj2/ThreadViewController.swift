  
//
//  ThreadTableViewController.swift
//  proj2
//
//  Created by admin on 5/12/21.
//
import UIKit

class ThreadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let ud = UserDefaults.standard
    var comment :  [Comment]?
    override func viewDidLoad() {
        super.viewDidLoad()
        comment = DBHelper.inst.getCommentFromThread(query: ud.string(forKey: "currForum") ?? "General")

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
        
        return comment?.count ?? 0
    }

  

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "threadCell", for: indexPath) as! CommentTableViewCell
        
        myCell.user.text = comment![indexPath.row].author.username
        myCell.comment.text = comment![indexPath.row].text
        

        
        return myCell
    }
    


}
