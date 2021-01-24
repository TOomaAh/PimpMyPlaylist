//
//  CustomTableViewCell.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 17/01/2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet public var label: UILabel!
    @IBOutlet var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func updateButtonLabel(_ sender: Any) {
        if self.button.titleLabel?.text == "A voir" {
            self.button.setTitle("Vu", for: .normal)
            self.button.setTitleColor(UIColor.green, for: .normal)
        }else if self.button.titleLabel?.text == "Vu"{
            self.button.setTitle("A voir", for: .normal)
            self.button.setTitleColor(UIColor.red, for: .normal)
        }
        
    }
}
