//
//  EditWatchlistViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class EditWatchlistViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Watchlist"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        var movie = Movie.init(ID: 1, original_title: "Pulp Fiction", poster_path: "path", video: true, vote_average: 10.1, vote_count: 10, release_date: Date(timeIntervalSinceNow: -693_792_000), title: "Pulp fiction", popularity: 10.0, adult: false, backdrop_path: "path", tmdb_id: 10, genre_id: [10, 11], overview: "film cool", original_language: "fr")
        movies.append(movie)
        movie = Movie.init(ID: 2, original_title: "Pulp Fiction", poster_path: "path", video: true, vote_average: 10.1, vote_count: 10, release_date: Date(timeIntervalSinceNow: -693_792_000), title: "Pulp fiction", popularity: 10.0, adult: false, backdrop_path: "path", tmdb_id: 10, genre_id: [10, 11], overview: "film cool", original_language: "fr")
        movies.append(movie)
        tableView.reloadData()
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "CustomTableViewCell")
    }

}

extension EditWatchlistViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            let movie = movies[indexPath.row]
            cell.label.text = movie.title
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
