//
//  MovieTableViewCell.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 17/01/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet public var labelKey: UILabel!
    @IBOutlet public var labelValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
