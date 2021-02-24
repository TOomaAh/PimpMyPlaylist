//
//  FriendsTableViewCell.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 10/02/2021.
//

import UIKit

protocol friendsAction: class {
    func goToWatchlist(cell: FriendsTableViewCell)
    func deleteFriend(cell: FriendsTableViewCell)
}

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet public var usernameLabel: UILabel!
    @IBOutlet weak var watchlistbutton: UIButton!
    @IBOutlet weak var delButton: UIButton!
    weak var delegate: friendsAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.watchlistbutton.setTitle(NSLocalizedString("controller.friendCell.watchlist", comment: ""), for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func watchlistNext(_ sender: Any) {
        delegate?.goToWatchlist(cell: self)
    }
    @IBAction func delFriend(_ sender: Any) {
        delegate?.deleteFriend(cell: self)
    }
}
