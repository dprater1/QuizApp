//
//  Views.swift
//  proj2
//
//  Created by Daivion Prater on 5/13/21.
//

import Foundation
import UIKit
import SideMenu

class roundButton : UIButton{
    
    required init?(coder: NSCoder){
        super.init(coder:coder)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}

extension UIButton {
    func btnCorner() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}

class commentsView : UITextView{
    required init?(coder: NSCoder){
        super.init(coder:coder)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}

class sideMenuView : sideMenus {
    
    required init?(coder: NSCoder){
        super.init(coder:coder)
        let nav = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(nav)
        let navItem = UINavigationItem(title: "")
        let image = UIImage(systemName: "line.horizontal.3")
        let menu = UIBarButtonItem(image: image, style: .plain, target: nil, action: #selector(setUp))
        navItem.leftBarButtonItem = menu
        nav.setItems([navItem], animated: false)
        nav.setBackgroundImage(UIImage(), for: .default)
        nav.shadowImage = UIImage()
        nav.isTranslucent = true
        
    }
}

class sideMenus : SideMenuNavigationController{
   
}

extension SideMenuNavigationController {
    
    func setUp(menu1: SideMenuNavigationController?){
    var menu1 = menu1
    menu1 = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
    menu1?.leftSide = true
    menu1?.setNavigationBarHidden(true, animated: false)
    SideMenuManager.default.leftMenuNavigationController = menu1
    SideMenuManager.default.addPanGestureToPresent(toView: view)
    let nav = UINavigationBar(frame: CGRect(x: 100, y: 100, width: view.frame.size.width, height: 44))
    view.addSubview(nav)
    let navItem = UINavigationItem(title: "")
    let image = UIImage(systemName: "line.horizontal.3")
    let menus = UIBarButtonItem(image: image, style: .plain, target: nil, action: #selector(setUp))
    navItem.leftBarButtonItem = menus
    nav.setItems([navItem], animated: false)
    nav.setBackgroundImage(UIImage(), for: .default)
    nav.shadowImage = UIImage()
    nav.isTranslucent = true
    print("view set up")
        
    }
    
}
