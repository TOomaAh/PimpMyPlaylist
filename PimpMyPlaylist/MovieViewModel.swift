//
//  MovieViewModel.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 19/01/2021.
//

import Foundation

class MovieViewModel {
    private var apiService = ApiService()
    private var resultMovies = [Movies]()
    
    func fetchResultMoviesData(completion: @escaping () -> ()) {
    
        apiService.getMoviesFromResearch(filmName: "Project") { [weak self] (result) in
            switch result {
            case.success(let listOfMovie):
                // self?.resultMovies = listOf.movies[0].title
                for movie in listOfMovie.movies {
                    
                    print(movie.title)
                }
                completion()
            case.failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    
    }
    
    func numberOfRowsInSelection(section: Int ) -> Int {
        if resultMovies.count != 0 {
            return resultMovies.count
        }
        return 0
    }
    
    func cellForRawAt(indexPath: IndexPath) -> Movies {
        return resultMovies[indexPath.row]
    }
}
