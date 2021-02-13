//
//  MovieViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 17/01/2021.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDelegate {
    let Api = ApiService()
    private var movie:TmdbMovie!
    var watchlistMoviesId: [Int] = []
    let imageService: ImageService = ImageService()
    var posterShown: Bool = false
    var clearImageView: UIImageView = UIImageView()
    var poster: UIImage!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var posterButton: UIButton!
    @IBOutlet var overviewTitleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var titleMovieLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    
    class func newInstance(nibName:String?, movie: TmdbMovie) -> MovieViewController{
        let movieView = MovieViewController(nibName: "MovieViewController", bundle: nil)
        movieView.movie = movie
        return movieView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPosterValue()
        self.setLabels()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
        self.registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //Set background & labels
    private func setLabels(){
        self.titleMovieLabel.text = movie.title
        self.overviewLabel.text = movie.overview
        self.overviewTitleLabel.text = NSLocalizedString("controller.movie.overviewTitle", comment: "")
        self.addButton.setTitle(NSLocalizedString("controller.movie.addButton", comment: ""), for: .normal)
        self.posterButton.setTitle(NSLocalizedString("controller.movie.poster", comment: ""), for: .normal)
    }
    
    private func setBlurBackground(){
        
        let imageView   = UIImageView(frame: self.view.bounds);
        imageView.image = self.poster
        self.view.addSubview(imageView)
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
        self.view.sendSubviewToBack(imageView)
    }
    
    private func setPosterValue(){
        guard let posterPath = movie.poster_path else {
            return
        }
        let url = URL.init(string: "https://image.tmdb.org/t/p/w500"+posterPath)
        if let pictureURL = url {
           self.imageService.getImage(from: pictureURL) { (img) in
               DispatchQueue.main.async {
                self.poster = img
                self.setBlurBackground()
               }
           }
       }
    }
    
    
    @IBAction func showPoster(_ sender: Any) {
        if !self.posterShown {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.clearImageView.frame = self.view.bounds
            self.clearImageView.image = self.poster
            self.clearImageView.tag = 10
            self.view.insertSubview(self.clearImageView, at: 10)
            self.view.insertSubview(self.posterButton, aboveSubview: self.clearImageView)
            self.posterShown = true
            self.posterButton.setTitle(NSLocalizedString("controller.movie.description", comment: ""), for: .normal)
            
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            if let viewWithTag = self.clearImageView.viewWithTag(10) {
                viewWithTag.removeFromSuperview()
                self.posterShown = false
                self.posterButton.setTitle(NSLocalizedString("controller.movie.poster", comment: ""), for: .normal)
            }
        }
    }
    
    
    
    //Register tables cells
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "MovieTableViewCell")
    }
    

    //Add movie to watchlist
    @IBAction func addWatchlist(_ sender: Any) {
        //Call api to add movie id to our watchlist and update the user movies
        self.addButton.setTitle("Added", for: .normal)
        let idFile = getDocumentsDirectory().appendingPathComponent("id.txt")
        let id = try! String(contentsOf: idFile)
        let userId = Int(id)
        Api.postMovie(movie: movie, userId: userId!) { [self] (result) in
            switch result{
            case .success(let film):
                Api.getAllMovie(id:id) { (result) in
                    switch result{
                    case .success(let moviesData):
                        let array = moviesData.arrayWatchListMovies
                        for movie in array {
                            watchlistMoviesId.append(movie.id!)
                        }
                        watchlistMoviesId.append(film.id)
                        Api.updateUserMovie(movieId: watchlistMoviesId) { (result) in
                            switch result{
                            case .success( _):
                                break
                            case .failure(let e):
                                print(e)
                                break
                            }
                        }
                        break
                    case .failure(let e):
                        print(e)
                        break
                    }
                }
            break
            case .failure(let error):
                print(error)
            break
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    

}

extension MovieViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell {
            switch indexPath.row {
            case 0:
                cell.labelKey.text = NSLocalizedString("controller.movie.date", comment: "")
                cell.labelValue.text = movie.release_date != nil ? movie.release_date : "n.c"
            case 1:
                cell.labelKey.text = NSLocalizedString("controller.movie.ogTitle", comment: "")
                cell.labelValue.text = movie.original_title
            case 2:
                cell.labelKey.text = NSLocalizedString("controller.movie.ogLanguage", comment: "")
                cell.labelValue.text = movie.original_language
            case 3:
                cell.labelKey.text = NSLocalizedString("controller.movie.popularity", comment: "")
                cell.labelValue.text = String(format: "%f", movie.popularity!)
            case 4:
                cell.labelKey.text = NSLocalizedString("controller.movie.genre", comment: "")
                cell.labelValue.text = String(format: "%d", movie.genre_ids)
            default:
                print("hi")
            }
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
