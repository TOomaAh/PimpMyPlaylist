//
//  UserLogin.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 30/01/2021.
//

import Foundation

struct UserLogin: Codable {
    var identifier: String
    var password: String
}

private enum CodingKeys: String, CodingKey {
    case identifier,password
}
