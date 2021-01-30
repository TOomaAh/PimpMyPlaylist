//
//  Role.swift
//  PimpMyPlaylist
//
//  Created by Anthony Jauch on 29/01/2021.
//

import Foundation

struct Role: Codable {
    var id: Int?
    var name: String
    var description: String
    var type: String
    
}

private enum CodingKeys: String, CodingKey {
    case id, name, description, type
}

struct RoleData: Codable {
    let arrayRole: [Role]
    
    private enum CodingKeys: String, CodingKey {
        case arrayRole = "role"
    }
}
