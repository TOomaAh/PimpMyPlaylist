//
//  TmdbMovie.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 24/01/2021.
//

import Foundation

struct MoviesData: Decodable {
    let arrayTmdbMovies: [TmdbMovie]
    
    private enum CodingKeys: String, CodingKey {
        case arrayTmdbMovies = "results"
    }
}

struct TmdbMovie: Decodable {
    
    let adult: Bool?
    let backdrop_path: String?
    let id: Int
    let original_language: String?
    let original_title: String?
    let overview: String
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
  
    
    private enum CodingKeys: String, CodingKey {
        case adult, backdrop_path, id, original_language, original_title, overview, popularity, poster_path, release_date, title, video, vote_average, vote_count
    }
}
