//
//  Movie.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 16/01/2021.
//

import Foundation

class Movie: CustomStringConvertible,Codable {
    private var ID:Int?
    private var original_title: String?
    private var poster_path: String?
    private var video: Bool?
    private var vote_average: Double?
    private var vote_count: Int?
    private var release_date: Date?
    public var title: String?
    private var popularity: Double?
    private var adult: Bool?
    private var backdrop_path: String?
    private var tmdb_id: Int?
    private var genre_id: [Int]?
    private var overview: String?
    private var original_language: String?
    private var date: String?
    public var description: String {
        return
            "Movie[ID: \(self.ID) ]"
           /* ", original_title: " + self.original_title +
            ", poster_path: " + self.poster_path +
            ", video: " + self.video +
            ", vote_average: " + self.vote_average +
            ", vote_count: " + self.vote_count +
            ", release_date: " + self.release_date +
            ", title: " + self.title +
            ", popularity: " + self.popularity +
            ", adult: " + self.adult +
            ", backdrop_path: " + self.backdrop_path +
            ", movie_ID: " + self.movie_ID +
            ", genre_id: " + self.genre_id +
            ", overview: " + self.overview +
            ", original_language: " + self.original_language + */
    }
    
     init(ID:Int, original_title:String,poster_path:String,video:Bool,
   vote_average:Double,vote_count:Int,release_date:Date,
   title:String,popularity:Double,adult:Bool,backdrop_path:String,
   tmdb_id:Int,genre_id:[Int],overview:String,original_language:String ){
        
        self.ID = ID
        self.original_title = original_title
        self.poster_path = poster_path
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
        self.release_date = release_date
        self.title = title
        self.popularity = popularity
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.tmdb_id = tmdb_id
        self.genre_id = genre_id
        self.overview = overview
        self.original_language = original_language
    }
    
    init(tmdb_id:Int,original_title:String,overview:String,genre_id:[Int],popularity:Double,date: String) {
        self.tmdb_id = tmdb_id
        self.original_title = original_title
        self.overview = overview
        self.genre_id = genre_id
        self.popularity = popularity
        self.date = date
    }
    
    func getTitle() -> String {
        self.original_title!
    }
    
    func getOverview() -> String {
        self.overview!
    }
    
    func getRelease() -> Date {
        self.release_date!
    }
    
    func getTmdb_id() -> Int {
        self.tmdb_id!
    }
    
    func getOriginalLanguage() -> String {
        self.original_language!
    }
    
    func getDate() -> String {
        self.date!
    }
    
    func getPopularity() -> Double {
        self.popularity!
    }
    
    func getGenreId() -> [Int] {
        self.genre_id!
    }
        
}
