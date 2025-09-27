//
//  UserDTO.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

struct UsersResponseDTO: Decodable {
    let success: Bool
    let totalPages: Int
    let totalUsers: Int
    let count: Int
    let page: Int
    let users: [UserDTO]
    
    private enum CodingKeys: String, CodingKey {
        case success
        case totalPages = "total_pages"
        case totalUsers = "total_users"
        case count, page, users
    }
}

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
