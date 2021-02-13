//
//  ResultViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 17/01/2021.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var resultView: UITableView!
    var movies: [TmdbMovie] = []
    var movieTitle:String!
    
    class func newInstance(nibName:String?, movieTitle: String) -> ResultViewController{
        let result = ResultViewController(nibName: "ResultViewController", bundle: nil)
        result.movieTitle = movieTitle
        return result;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callTmdbApi(filmTitle: self.movieTitle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    func callTmdbApi(filmTitle: String)->Void{
        let Api = ApiService()
        Api.getMoviesFromResearch(filmName: filmTitle) { [self] (results) in
            switch results{
            case .success(let moviesData):
                let m = moviesData.arrayTmdbMovies
                for movie in  m{
                    movies.append(movie)
                }
                self.resultView.dataSource = self
                self.resultView.delegate = self
                self.registerTableViewCells()
                self.resultView.tableFooterView = UIView()
                self.resultView.backgroundColor = UIColor.clear
                break
                
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "ResultTableViewCell", bundle: nil)
        self.resultView.register(textFieldCell, forCellReuseIdentifier: "ResultTableViewCell")
    }

}

extension ResultViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as? ResultTableViewCell {
            cell.label.text = movies[indexPath.row].title
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //IndexRow = Case du tableau des reponses, envoyer id Film TMDB au MovieViewController
        let movieView = MovieViewController.newInstance(nibName: "MovieViewController", movie: movies[indexPath.row])
        self.navigationController?.pushViewController(movieView, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
