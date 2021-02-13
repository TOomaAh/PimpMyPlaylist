//
//  Friend.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 09/02/2021.
//

import Foundation

struct Friend: Codable {
    var id: Int
    var username: String
    var email: String
    var provider: String?
    var confirmed: Bool
    var blocked: Bool
    var role: Int?
    var created_by: String?
    var updated_by: String?
}

private enum CodingKeys: String, CodingKey {
    case id, username, email, provider, confirmed, blocked, role, movie, created_by, updated_by
}

struct ArrayFriend: Codable{
    let arrayFriend: [Friend]
    
    private enum CodingKeys: String, CodingKey{
       case arrayFriend = "friends"
    }
}
