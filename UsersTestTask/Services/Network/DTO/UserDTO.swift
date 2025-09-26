//
//  UserDTO.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let positionId: Int
    let registrationTimestamp: Double
    let photo: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, email, phone, position
        case positionId = "position_id"
        case registrationTimestamp = "registration_timestamp"
        case photo
    }
}
