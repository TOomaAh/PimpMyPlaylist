//
//  MenuViewController.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 16/01/2021.
//

import UIKit

class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
            let api = ApiService()
        let movie = TmdbMovie(adult: false, backdrop_path: "test/test", genre_ids: [1,3], id: 124451, original_language: "en", original_title: "testtest", overview: "ceci est un test", popularity: 23.5, poster_path: "/peooir/jjieu", release_date: "2002-02-10", title: "LeTest", video: false, vote_average: 122.33, vote_count: 7655)
        let user = User(jwt: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjEyMDE4OTQ2LCJleHAiOjE2MTQ2MTA5NDZ9.dnhC1kvhb7lGKo8apan8H9NEGGIjgZlh3Cs73dCssAA",id: 2, username: "anthotest", email: "anthony@hotmail.fr", provider: "local", password: "azerty", confirmed: true, blocked: false)
        
        /*api.postMovie(movie: movie, user: user) { (result) in
            switch result{
            case.success(let film):
            print(film.title)
            break
                
            case.failure(let e):
            print(e)
            break
            }
        }*/
        
        api.connectUser(user: user) { (result) in
            switch result{
            case.success(let user):
            print(user.identifier)
            break
                
            case.failure(let e):
            print(e)
            break
            }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
