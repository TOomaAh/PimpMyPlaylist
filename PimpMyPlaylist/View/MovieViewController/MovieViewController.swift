//
//  MovieViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 17/01/2021.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDelegate {
    let Api = ApiService()
    
    @IBOutlet var tableView: UITableView!
    private var movie:TmdbMovie!
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
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
        self.registerTableViewCells()
        self.titleMovieLabel.text = movie.title
        self.overviewLabel.text = movie.overview
        
        //Get all infos from tmbd then fill the following infos
    }
    
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    @IBAction func addWatchlist(_ sender: Any) {
        //Call api to add movie id to our watchlist
        self.addButton.setTitle("Added", for: .normal)
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
                cell.labelKey.text = "Release Date"
                cell.labelValue.text = movie.release_date != nil ? movie.release_date : "n.c"
            case 1:
                cell.labelKey.text = "Original Title"
                cell.labelValue.text = movie.original_title
            case 2:
                cell.labelKey.text = "Original Language"
                cell.labelValue.text = movie.original_language
            case 3:
                cell.labelKey.text = "Popularity"
                cell.labelValue.text = String(format: "%f", movie.popularity!)
            case 4:
                cell.labelKey.text = "Genres"
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
