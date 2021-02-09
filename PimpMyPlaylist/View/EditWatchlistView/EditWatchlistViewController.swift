//
//  EditWatchlistViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class EditWatchlistViewController: UIViewController, UITableViewDelegate, CustomCellDelegate {
    
    

    @IBOutlet var tableView: UITableView!
    var watchlistMovies: [WatchListMovie] = []
    @IBOutlet var watchlistLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Watchlist"
        self.watchlistLabel.text = NSLocalizedString("controller.edit.watchlistLabel", comment: "")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
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
                let array = moviesData.arrayWatchListMovies
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
            cell.delegate = self
            cell.label.text = watchlistMovies[indexPath.row].title
            cell.button.setTitle(watchlistMovies[indexPath.row].watched ? "vu" : "à voir", for: .normal)
            cell.movieID = watchlistMovies[indexPath.row]
            cell.button.setTitleColor(watchlistMovies[indexPath.row].watched ? UIColor.green : UIColor.red, for: .normal)
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func sharePressed(cell: CustomTableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        let Api = ApiService()
        Api.deleteMovie(id: watchlistMovies[index].id)
        watchlistMovies.remove(at: index)
        let indexPath = IndexPath(item: index, section: 0)
        tableView.deleteRows(at:[indexPath], with: .fade)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
