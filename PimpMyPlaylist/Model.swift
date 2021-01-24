//
//  Model.Swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 18/01/2021.
//

import Foundation

struct MoviesData: Decodable {
    let arrayTmdbMovies: [TmdbMovies]
    
    private enum CodingKeys: String, CodingKey {
        case arrayTmdbMovies = "results"
    }
}

struct TmdbMovies: Decodable {
    
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language: String?
    let original_title: String?
    let overview: String
    let popularity: Double?
    let poster_path: String?
    let release_date: String
    let title: String
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
  
    
    private enum CodingKeys: String, CodingKey {
        case adult, backdrop_path, genre_ids, id, original_language, original_title, overview, popularity, poster_path, release_date, title, video, vote_average, vote_count
    }
}

struct WatchListMovies: Codable{
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
    let arrayWatchListMovies: [WatchListMovies]
    
    private enum CodingKeys: String, CodingKey {
        case arrayWatchListMovies = "Movies"
    }
}
    
 
