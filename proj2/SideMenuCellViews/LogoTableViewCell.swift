//
//  LogoTableViewCell.swift
//  proj2
//
//  Created by Daivion Prater on 5/13/21.
//

import UIKit

class LogoTableViewCell: UITableViewCell {

    static let identifier = "LogoTableViewCell"
    private let myImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    public func configure(){
        contentView.addSubview(myImageView)
        myImageView.image = UIImage(named: "Celestial_Questions-3-removebg-preview.png")
        myImageView.contentMode = .scaleAspectFit
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: -35, y: -70, width: 300, height: 300)
        
        
        
        
    }
    
}
