//
//  UserRegisterResponse.swift
//  UsersTestTask
//
//  Created by realeti on 02.10.2025.
//

import Foundation

struct UserRegisterResponse {
    let success: Bool
    let message: String
    
    init(dto: UserRegisterDTO) {
        self.success = dto.success
        self.message = dto.message
    }
}
