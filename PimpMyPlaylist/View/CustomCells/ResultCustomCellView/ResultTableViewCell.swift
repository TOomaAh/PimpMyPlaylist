//
//  ResultTableViewCell.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 17/01/2021.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet public var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCellWithValueOf(_ movie:TmdbMovie) {
        updateUI(title: movie.title)
    }
    
    func updateUI(title: String?){
        self.label.text = title
    }
    
}
