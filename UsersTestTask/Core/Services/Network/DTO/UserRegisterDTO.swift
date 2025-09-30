//
//  UserRegisterDTO.swift
//  UsersTestTask
//
//  Created by realeti on 30.09.2025.
//

import Foundation

struct UserRegisterDTO: Decodable {
    let success: Bool
    let userId: Int
    let message: String
    let fails: UserRegisterFailureDTO
    
    private enum CodingKeys: String, CodingKey {
        case success
        case userId = "user_id"
        case message, fails
    }
}

struct UserRegisterFailureDTO: Decodable {
    let name: [String]?
    let email: [String]?
    let phone: [String]?
    let positionId: [String]?
    let photo: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case name, email, phone
        case positionId = "position_id"
        case photo
    }
}
