//
//  WatchListMovie.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 22/01/2021.
//

import Foundation


class WatchListMovie: Codable{
     var id: Int?
     var title: String
     var tmdb_id: Int
     var watched: Bool
     var year: Int
    
    init(title: String, tmdb_id:Int, watched: Bool, year: Int) {
        self.title = title
        self.tmdb_id = tmdb_id
        self.watched = watched
        self.year = year

    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, tmdb_id,watched,year
    }
    
    
    func getId() -> Int {
        self.id!
    }
    
    func getTitle() -> String {
        self.title
    }
    
    func getTmdb_id() -> Int {
        self.tmdb_id
    }
    
    func getWatched() -> Bool {
        self.watched
    }
    
    func getYear() -> Int {
        self.year
    }
 
}


