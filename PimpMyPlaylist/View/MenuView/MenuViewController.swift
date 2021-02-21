//
//  MenuViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var movieDetailsButton: UIButton!
    let api = ApiService()
    var imageService: ImageService = ImageService()
    @IBOutlet var searchButton: UIButton!
    var movies: [TmdbMovie] = []
    var timer: Timer!
    var counter = 0
    @IBOutlet var editButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var topRatedLabel: UILabel!
    var url:URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchButton.setTitle(NSLocalizedString("controller.menu.search", comment: ""), for: .normal)
        self.editButton.setTitle(NSLocalizedString("controller.menu.edit", comment: ""), for: .normal)
        self.topRatedLabel.text = NSLocalizedString("controller.menu.topRated", comment: "")
        let api = ApiService()
        api.getMoviesFromPopular { [self] (result) in
            switch result{
            case.success(let moviesData):
                let m = moviesData.arrayTmdbMovies
                for movie in m{
                    self.movies.append(movie)
                }
                updatePicture()
                self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updatePicture), userInfo: nil, repeats: true)
                break
                
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func updatePicture(){
        guard let url = self.movies[counter].poster_path else {
            return
        }
        let finalUrl = "https://image.tmdb.org/t/p/w500"+url
        self.fetchAndReloadImageView(poster: URL.init(string: finalUrl))
        counter+=1
        if counter == 20 {
            counter = 0
        }
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
        
    // MARK: - Navigation

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    private func fetchAndReloadImageView(poster:URL?) {
        if let pictureURL = poster {
           self.imageService.getImage(from: pictureURL) { (img) in
               DispatchQueue.main.async {
                   self.imageView.image = img
               }
           }
       }
   }
    @IBAction func handleDetails(_ sender: Any) {
        let movieView = MovieViewController.newInstance(nibName: "MovieViewController", movie: self.movies[counter-1])
        self.navigationController?.pushViewController(movieView, animated: true)
    }
    
}
