//
//  RegisterUser.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 10/02/2021.
//

import Foundation

struct RegisterUser: Codable {
    var username: String
    var email: String
    var password: String
    var confirmed: Bool
    var blocked: Bool
}

private enum CodingKeys: String, CodingKey {
    case username, email, password, confirmed, blocked
}


