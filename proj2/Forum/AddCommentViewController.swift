//
//  AddCommentViewController.swift
//  proj2
//
//  Created by admin on 5/13/21.
//

import UIKit
import SideMenu

class AddCommentViewController: UIViewController {
    let ud = UserDefaults.standard

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var nav: UINavigationBar!
    var menu : SideMenuNavigationController?
    override func viewDidLoad() {
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        nav.setBackgroundImage(UIImage(), for: .default)
        nav.shadowImage = UIImage()
        nav.isTranslucent = true
        
        super.viewDidLoad()
        label.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.4, shadowPathInset: (dx: 16, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addComment(_ sender: Any) {
        if(commentText.text.count > 140){
            let alert = UIAlertController(title: "Your comment was too long", message: "please restrict your messageto 200 characters", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
            
        }
        
        let comment = Comment(author: ud.string(forKey: "currUser") ?? "Unknown User", text: commentText.text, thread: ud.string(forKey: "currForum") ?? "General")
        DBHelper.inst.addCommentToThread(comment: comment)
        
        let sb : UIStoryboard = UIStoryboard(name: "Forum", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "Thread") as! ThreadViewController
        present(wel, animated: true, completion: nil)
    }
    
    @IBAction func didTap(_ sender: Any) {
        present(menu!, animated: true)
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
