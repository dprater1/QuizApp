//
//  SideMenuTableViewController.swift
//  proj2
//
//  Created by Daivion Prater on 5/12/21.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
    
    var bcColor = UIView()
    var ud = UserDefaults()
    
    var textData = ["","","Log Out","Subscribe","Current Rank", "", "Review"]
    var imgData = ["","","pip.exit","dollarsign.square","star", "clock", "pencil"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self , forCellReuseIdentifier:"cell")
                // Uncomment the following line to preserve selection between presentations
        tableView.backgroundView = UIImageView(image: UIImage(named: "blueishpinkgradient"))
        tableView.separatorStyle = .none
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier:"ImageTableViewCell")
        tableView.register(LogoTableViewCell.self,forCellReuseIdentifier: "LogoTableViewCell")
        tableView.register(IconTableViewCell.self,forCellReuseIdentifier: "IconTableViewCell")
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return textData.count
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 150
        }else if(indexPath.row == 1){
            return 200
        }
        else{
            return 70
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: LogoTableViewCell.identifier, for: indexPath) as! LogoTableViewCell
            cell.configure()
            cell.backgroundColor = .clear
            bcColor.backgroundColor = .clear
            cell.selectedBackgroundView = bcColor
            return cell
            
        }
        if(indexPath.row == 1){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
            var current = DBHelper.init().fetchUser(query: ud.string(forKey: "currUser") ?? "Username")
            textData[indexPath.row] = current?.username! ?? ""
            cell.configure(label: textData[indexPath.row])
            cell.backgroundColor = .clear
            bcColor.backgroundColor = .clear
            cell.selectedBackgroundView = bcColor
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: IconTableViewCell.identifier, for: indexPath) as! IconTableViewCell
        cell.configure(imageNamed: imgData[indexPath.row], label: textData[indexPath.row], color: .black)
        cell.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.8, shadowPathInset: (dx: 16, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        if(indexPath.row == 2){
            cell.configure(imageNamed: imgData[indexPath.row], label: textData[indexPath.row], color: .red)
            
        }
        if(indexPath.row == 5){
            var user = DBHelper.init().fetchUser(query: ud.string(forKey: "currUser") ?? "Not Subscribed")
            if(user?.subscribed != false){
                textData[indexPath.row] = "30 days remaining"
            }
            else{
                textData[indexPath.row] = "Not Subscribed"
            }
            
        }
        cell.backgroundColor = .clear
        bcColor.backgroundColor = UIColor(red: 176/255.0, green: 204/255.0, blue: 220/255.0, alpha: 1)
        cell.selectedBackgroundView = bcColor
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 2){
            LoginViewController.loginManager.logOut()
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            present(wel, animated: true, completion: nil)
        }
        if(indexPath.row == 3){
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "Subscribe") as! SubscribeViewController
            present(wel, animated: true, completion: nil)
        }
        
    }
    
       /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
