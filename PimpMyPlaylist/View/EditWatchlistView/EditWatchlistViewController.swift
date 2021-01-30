//
//  EditWatchlistViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class EditWatchlistViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var watchlistMovies: [WatchListMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Watchlist"
      

        getAllWatchListMovie()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
       // tableView.reloadData()
    }
    
    
    func getAllWatchListMovie(){
        let Api = ApiService()
        Api.getAllMovie {  [self] (results) in
            switch results{
            case .success(let moviesData):
                let array = moviesData.self
                for movie in array {
                    watchlistMovies.append(movie)
                }
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.registerTableViewCells()
                self.tableView.tableFooterView = UIView()
                self.tableView.backgroundColor = UIColor.clear
                self.tableView.reloadData()
                break
            case .failure(let e):
                print(e)
                break
            }
        }
    }
    
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "CustomTableViewCell")
    }

}

extension EditWatchlistViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlistMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            cell.label.text = watchlistMovies[indexPath.row].title
            cell.button.setTitle(watchlistMovies[indexPath.row].watched ? "vu" : "à voir", for: .normal)
            cell.movieID = watchlistMovies[indexPath.row]
            cell.button.setTitleColor(watchlistMovies[indexPath.row].watched ? UIColor.green : UIColor.red, for: .normal)
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("toto")
    }
}
