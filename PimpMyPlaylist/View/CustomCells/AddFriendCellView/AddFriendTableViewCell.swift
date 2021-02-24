//
//  AddFriendTableViewCell.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 17/02/2021.
//

import UIKit

protocol AddFriendCellDelegate: class {
    func addFriend(cell: AddFriendTableViewCell)
}

class AddFriendTableViewCell: UITableViewCell {

    @IBOutlet public var nameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    weak var delegate: AddFriendCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addButton.setTitle(NSLocalizedString("controller.addFriendCell.add", comment: ""), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addFriendAction(_ sender: Any) {
        delegate?.addFriend(cell: self)
    }
    
}
