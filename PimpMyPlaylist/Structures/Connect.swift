//
//  Connect.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 30/01/2021.
//

import Foundation

struct Connect: Codable {
    var jwt: String
    var user: User
}

private enum CodingKeys: String, CodingKey {
    case jwt,user
}
