//
//  ResultWatchListMovie.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 30/01/2021.
//

import Foundation

struct UpdateWatchListMovie: Codable{
    var movies: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case movies
    }
}
