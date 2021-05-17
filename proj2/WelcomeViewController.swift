//
//  WelcomeViewController.swift
//  proj2
//
//  Created by Daivion Prater on 5/12/21.
//

import UIKit
import SideMenu

class WelcomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let quizzes : [Quiz] = DBHelper.inst.fetchAllQuiz()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = quizzes[indexPath.row].name
        return cell
    }
    
    var menu : SideMenuNavigationController?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nav: UINavigationBar!
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        nav.setBackgroundImage(UIImage(), for: .default)
        nav.shadowImage = UIImage()
        nav.isTranslucent = true
        //menu?.settings.
        // Do any additional setup after loading the view.
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
