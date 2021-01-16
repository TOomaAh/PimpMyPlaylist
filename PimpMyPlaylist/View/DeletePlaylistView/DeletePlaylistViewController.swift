//
//  DeletePlaylistViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class DeletePlaylistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Delete Playlist"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
}
