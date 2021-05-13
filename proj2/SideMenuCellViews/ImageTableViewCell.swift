//
//  ImageTableViewCell.swift
//  proj2
//
//  Created by Daivion Prater on 5/13/21.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    static let identifier = "ImageTableViewCell"

    private let myLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    private let myImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    public func configure(label : String) {
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        
        myLabel.text = label
        myLabel.textAlignment = .center
        myImageView.image = UIImage(systemName: "people.crop.circle")
        myImageView.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
        myLabel.frame = CGRect(x: 105, y: 5, width: contentView.frame.size.width - 105, height: 100)
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 50.0
    }

}
