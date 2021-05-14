//
//  SingleCommentViewController.swift
//  proj2
//
//  Created by admin on 5/14/21.
//

import UIKit

class SingleCommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let ud = UserDefaults.standard
    var topComment = 0
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var listOfComments = DBHelper.inst.getCommentFromThread(query: ud.string(forKey: "currForum") ?? "General")
        topComment = ud.integer(forKey: "comment")
        return listOfComments![topComment].replies!.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 110
        var listOfComments = DBHelper.inst.getCommentFromThread(query: ud.string(forKey: "currForum") ?? "General")
        var currComment = listOfComments![topComment]
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CommentTableViewCell
        if(indexPath.row == 0){
            print("here")
            myCell.innerUser.text = currComment.author
            myCell.innerComment.text = currComment.text
            
        }
        else{
            myCell.innerUser.text = currComment.replies![indexPath.row-1].author
            myCell.innerComment.text = currComment.replies![indexPath.row-1].text
        }
        return myCell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
