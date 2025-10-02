//
//  UserPositionsDTO.swift
//  UsersTestTask
//
//  Created by realeti on 28.09.2025.
//

import Foundation

struct UserPositionsDTO: Decodable {
    let success: Bool
    let positions: [PositionDTO]
}

struct PositionDTO: Decodable {
    let id: Int
    let name: String
}
