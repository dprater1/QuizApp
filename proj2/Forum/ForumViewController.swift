//
//  ForumViewController.swift
//  proj2
//
//  Created by admin on 5/11/21.
//
import UIKit
import SideMenu

class ForumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var bcColor = UIView()
    let topics = ["iOS", "General", "Java"]
    var menu : SideMenuNavigationController?
    @IBOutlet weak var nav: UINavigationBar!
    let ud = UserDefaults.standard
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Forcell", for: indexPath) as! ForumTableViewCell
        cell.ForumTitle.text = topics[indexPath.row]
        tableView.rowHeight = 102
        cell.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.8, shadowPathInset: (dx: 16, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        cell.backgroundColor = .clear
        bcColor.backgroundColor = UIColor(red: 176/255.0, green: 204/255.0, blue: 220/255.0, alpha: 1)
        cell.selectedBackgroundView = bcColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ud.setValue(topics[indexPath.item], forKey: "currForum")
        let sb : UIStoryboard = UIStoryboard(name: "Forum", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "Thread") as! ThreadViewController
        present(wel, animated: true, completion: nil)
        
        
        
    }

    @IBAction func didTap(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    
}
