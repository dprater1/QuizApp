  
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
        comment = DBHelper.inst.getCommentFromThread(query: ud.string(forKey: "currForum") ?? "General")
        print(comment?.count)
        return comment?.count ?? 0
    }

  
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 110
        let myCell = tableView.dequeueReusableCell(withIdentifier: "threadCell", for: indexPath) as! CommentTableViewCell
        //print(comment![indexPath.row].author)
        myCell.user.text = comment![indexPath.row].author
        myCell.comment.text = comment![indexPath.row].text
        //print(comment!.count)
        
        

        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ud.setValue(indexPath.row, forKey: "comment")
        let sb : UIStoryboard = UIStoryboard(name: "Forum", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "SingleComment") as! SingleCommentViewController
        present(wel, animated: true, completion: nil)
        
        
        
    }

    


}
