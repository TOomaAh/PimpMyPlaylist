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
    
    private func fetchAndReloadImageView() {
        if let pictureURL = self.url {
            self.imageService.getImage(from: pictureURL) { (img) in
                DispatchQueue.main.async {
                    self.imageView.image = img
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
