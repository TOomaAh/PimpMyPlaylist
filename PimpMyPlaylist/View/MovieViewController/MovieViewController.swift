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
    private var movieInfo = [String]()
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var titleMovieLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
        self.registerTableViewCells()
        
        //Get all infos from tmbd then fill the following infos
        
        self.movieInfo.append("16/04/1998")
        self.movieInfo.append("Original title du film")
        self.movieInfo.append("English")
        self.movieInfo.append("10,5")
        self.movieInfo.append("Guerre, Thriller")
        self.overviewLabel.text = "Le film se passe la bas Le film se passe la bas Le film se passe la bas Le film se passe la bas"
    }
    
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    @IBAction func addWatchlist(_ sender: Any) {
        //Call api to add movie id to our watchlist
        self.addButton.setTitle("Added", for: .normal)
        let testmovie = Movie.init(tmdb_id: 12, original_title: "MAc", overview: "ok", genre_id: [12,6], popularity: 12.7, date: "2015-01-29")
        Api.postMovie(movie: testmovie) { result in
            switch result{
            case .success(let film):
                print(film.self.title)
            break
                
            case .failure(let error):
                print(error)
            break
            }
        }
        
    }
    

}

extension MovieViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell {
            switch indexPath.row {
            case 0:
                cell.labelKey.text = "Release Date"
                cell.labelValue.text = movieInfo[0]
            case 1:
                cell.labelKey.text = "Original Title"
                cell.labelValue.text = movieInfo[1]
            case 2:
                cell.labelKey.text = "Original Language"
                cell.labelValue.text = movieInfo[2]
            case 3:
                cell.labelKey.text = "Popularity"
                cell.labelValue.text = movieInfo[3]
            case 4:
                cell.labelKey.text = "Genres"
                cell.labelValue.text = movieInfo[4]
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
