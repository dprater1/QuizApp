//
//  CommentTableViewCell.swift
//  proj2
//
//  Created by admin on 5/12/21.
//
import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var innerComment: UILabel!
    @IBOutlet weak var innerUser: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var user: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
