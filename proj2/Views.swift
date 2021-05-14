//
//  Views.swift
//  proj2
//
//  Created by Daivion Prater on 5/13/21.
//

import Foundation
import UIKit

class roundButton : UIButton{
    
    required init?(coder: NSCoder){
        super.init(coder:coder)
        layer.cornerRadius = 10
        clipsToBounds = true    }
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

class sideMenuView : UIView{
    
    required init?(coder: NSCoder){
        super.init(coder:coder)
        var nav : UINavigationBar
        var menu : UIBarButtonItem
        
    }
}
