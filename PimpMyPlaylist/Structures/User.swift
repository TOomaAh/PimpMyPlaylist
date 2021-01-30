//
//  User.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 29/01/2021.
//

import Foundation

struct User: Codable {
    var jwt: String
    var id: Int
    var username: String
    var email: String
    var provider: String?
    var password: String
    var confirmed: Bool
    var blocked: Bool
    var role: Role?
    var movie: String?
    var created_by: String?
    var updated_by: String?
}

private enum CodingKeys: String, CodingKey {
    case jwt, id, username, email, provider, password, confirmed, blocked, role, movie, created_by, updated_by
}

struct UserData: Codable {
    let arrayUser: [User]
    
    private enum CodingKeys: String, CodingKey {
        case arrayUser = "user"
    }
}
