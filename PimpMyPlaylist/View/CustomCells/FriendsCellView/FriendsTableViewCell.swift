//
//  FriendsTableViewCell.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 10/02/2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet public var usernameLabel: UILabel!
    @IBOutlet var watchlistbutton: UIButton!
    @IBOutlet var delButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
