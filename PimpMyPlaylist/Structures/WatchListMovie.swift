//
//  WatchListMovie.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 24/01/2021.
//

import Foundation

struct WatchListMovie: Codable{
     var id: Int?
     var title: String
     var tmdb_id: Int
     var watched: Bool
     var year: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, title, tmdb_id,watched,year
    }
}

struct WatchListMovieData: Codable {
    let arrayWatchListMovies: [WatchListMovie]
    
    private enum CodingKeys: String, CodingKey {
        case arrayWatchListMovies = "Movies"
    }
}
