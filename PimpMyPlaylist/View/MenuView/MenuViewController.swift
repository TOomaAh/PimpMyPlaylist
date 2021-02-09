//
//  MenuViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class MenuViewController: UIViewController {
    
    var imageService: ImageService = ImageService()
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var topRatedLabel: UILabel!
    var url:URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchButton.setTitle(NSLocalizedString("controller.menu.search", comment: ""), for: .normal)
        self.editButton.setTitle(NSLocalizedString("controller.menu.edit", comment: ""), for: .normal)
        self.topRatedLabel.text = NSLocalizedString("controller.menu.topRated", comment: "")
        self.url = URL.init(string: "https://image.tmdb.org/t/p/w500/fYtHxTxlhzD4QWfEbrC1rypysSD.jpg")
        DispatchQueue.main.async {
            self.fetchAndReloadImageView()
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func searchMoviesNext(_ sender: Any) {
        let research = ResearchViewController(nibName: "ResearchViewController", bundle: nil)
        self.navigationController?.pushViewController(research, animated: true)
    }
    
    @IBAction func editWatchlistNext(_ sender: Any) {
        let editWatchList = EditWatchlistViewController(nibName: "EditWatchlistViewController", bundle: nil)
        self.navigationController?.pushViewController(editWatchList, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
    private func fetchAndReloadImageView() {
        if let pictureURL = self.url {
            self.imageService.getImage(from: pictureURL) { (img) in
                DispatchQueue.main.async {
                    self.imageView.image = img
                }
            }
        }
    }
    
    // MARK: - Navigation

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}
