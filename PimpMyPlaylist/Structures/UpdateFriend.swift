//
//  UpdateFriend.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 10/02/2021.
//

import Foundation

struct UpdateFriend: Codable{
    var friends: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case friends
    }
}
