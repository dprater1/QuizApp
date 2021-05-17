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
    var bcColor = UIView()
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
        tableView.rowHeight = 275
        var listOfComments = DBHelper.inst.getCommentFromThread(query: ud.string(forKey: "currForum") ?? "General")
        var currComment = listOfComments![topComment]
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CommentTableViewCell
        myCell.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.8, shadowPathInset: (dx: 16, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        myCell.backgroundColor = .clear
        bcColor.backgroundColor = UIColor(red: 176/255.0, green: 204/255.0, blue: 220/255.0, alpha: 1)
        myCell.selectedBackgroundView = bcColor

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
