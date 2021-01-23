//
//  MenuViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class MenuViewController: UIViewController {
    let Api = ApiService()
    override func viewDidLoad() {
        super.viewDidLoad()
       /*var result = Api.fetchMovie(filmTitle: "le Seigneur des ")
        print(result)*/
        let test = Api.fecthMovieById(id: 4)
        print(test)
        
        Api.getAllMovie { (result) in
            switch result{
            case .success(let watchList):
                for watchListMovie in watchList.watchListData {
                    print(watchListMovie.watched)
                }
                break
            case .failure(let e):
                print(e)
                break
            }
        }
     /*   Api.getMoviesFromResearch(filmName: "Le Seigneur des ") { (result) in
            switch result {
            case .success(let movie):
                //let j = movie.movies[0].title
                for movieInfo in movie.movies {
                    print(movieInfo.title)
                    print(movieInfo.overview)
                    print(movieInfo.genreIds)
                    print(movieInfo.rate)
                    print(movieInfo.year)

                }
                break
            case .failure(let e):
                print(e)
                break

            }
        }*/
        
        

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
