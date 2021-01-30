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
     var description: String
     var tmdb_id: Int
     var watched: Bool
     var users: Int
     var date: String
     var published_at: String?
     var created_by: String?
     var updated_by: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, tmdb_id,watched,users, date, published_at, created_by, updated_by
    }
}

struct WatchListMovieData: Codable {
    let arrayWatchListMovies: [WatchListMovie]
    
    private enum CodingKeys: String, CodingKey {
        case arrayWatchListMovies
    }
}
