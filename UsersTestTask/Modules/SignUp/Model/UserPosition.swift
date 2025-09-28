//
//  UserPosition.swift
//  UsersTestTask
//
//  Created by realeti on 28.09.2025.
//

import Foundation

struct UserPosition: Identifiable, Comparable {
    let id: Int
    let name: String
    
    static func < (lhs: UserPosition, rhs: UserPosition) -> Bool {
        lhs.id < rhs.id
    }
}

extension UserPosition {
    init(dto: PositionDTO) {
        self.id = dto.id
        self.name = dto.name
    }
}
