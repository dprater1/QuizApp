//
//  IconTableViewCell.swift
//  proj2
//
//  Created by Daivion Prater on 5/13/21.
//

import UIKit

class IconTableViewCell: UITableViewCell {

    static let identifier = "IconTableViewCell"
    
    private let myLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    private let myImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    public func configure(imageNamed: String, label : String, color : UIColor) {
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        myLabel.text = label
        myLabel.textAlignment = .center
        myLabel.textColor = color
        myLabel.font = UIFont.init(name: "Avenir", size: 20)
        myImageView.image = UIImage(systemName: imageNamed)
        myImageView.tintColor = UIColor.black
        myImageView.contentMode = .scaleAspectFit
        //backgroundViews.contentMode = .scaleToFill
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.sizeToFit()
        let iconSize : CGFloat = 30
        let iconX: CGFloat = (frame.size.width -  iconSize - 140) / 2
        myImageView.frame = CGRect(x: iconX, y: (frame.size.height-iconSize)/2,width: iconSize, height: iconSize)
        myLabel.frame = CGRect(x: iconX + iconSize + 20, y: 0, width: myLabel.frame.size.width, height: frame.size.height)
    }
    
}
