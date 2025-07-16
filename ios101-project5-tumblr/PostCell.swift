//
//  PostCell.swift
//  ios101-project5-tumblr
//
//  Created by Lei Lei on 7/16/25.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var Image_box: UIImageView!
    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
