//
//  User.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

struct User: Identifiable, Comparable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let positionId: Int
    let registrationTimestamp: Double
    let photo: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.registrationTimestamp < rhs.registrationTimestamp
    }
}

extension User {
    init(dto: UserDTO) {
        self.id = dto.id
        self.name = dto.name
        self.email = dto.email
        self.phone = dto.phone
        self.position = dto.position
        self.positionId = dto.positionId
        self.registrationTimestamp = dto.registrationTimestamp
        self.photo = dto.photo
    }
}
