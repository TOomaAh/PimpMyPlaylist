//
//  Model.Swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 18/01/2021.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movies]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movies: Decodable {
    
    let title: String
    let year: String
    let id: Int
    let overview: String
    let posterImage: String?
    let rate: Double
    let genreIds: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case title, overview, id
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case genreIds = "genre_ids"
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
    let watchListData: [WatchListMovies]
    
    private enum CodingKeys: String, CodingKey {
        case watchListData = "Movies"
    }
}
    
 
