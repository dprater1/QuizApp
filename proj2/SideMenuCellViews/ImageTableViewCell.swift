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
        myLabel.textColor = .black
        myLabel.font = UIFont.init(name: "Avenir Heavy", size: 17)
        myImageView.image = UIImage(named: "silhoutte.png")
        myImageView.tintColor = UIColor.gray
        myImageView.contentMode = .scaleAspectFit
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 70, y: 35, width: 100, height: 100)
        myLabel.frame = CGRect(x: 52, y: 100, width: contentView.frame.size.width - 105, height: 100)
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 50.0
    }

}
extension UITableViewCell {
    func addShadow(backgroundColor: UIColor = .white, cornerRadius: CGFloat = 12, shadowRadius: CGFloat = 5, shadowOpacity: Float = 0.1, shadowPathInset: (dx: CGFloat, dy: CGFloat), shadowPathOffset: (dx: CGFloat, dy: CGFloat)) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: shadowPathInset.dx, dy: shadowPathInset.dy).offsetBy(dx: shadowPathOffset.dx, dy: shadowPathOffset.dy), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = backgroundColor
        whiteBackgroundView.layer.cornerRadius = cornerRadius
        whiteBackgroundView.layer.masksToBounds = true
        whiteBackgroundView.clipsToBounds = false
        
        whiteBackgroundView.frame = bounds.insetBy(dx: shadowPathInset.dx, dy: shadowPathInset.dy)
        insertSubview(whiteBackgroundView, at: 0)
    }
}
