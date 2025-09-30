//
//  ValidationError.swift
//  UsersTestTask
//
//  Created by realeti on 30.09.2025.
//

import Foundation

enum ValidationError: Error {
    case invalidName
    case invalidEmail
    case invalidPhoneNumber
    case invalidPhoto
    
    var description: String {
        switch self {
        case .invalidName:
            "Invalid name format"
        case .invalidEmail:
            "Invalid email format"
        case .invalidPhoneNumber:
            "Invalid phone format"
        case .invalidPhoto:
            "Invalid photo format"
        }
    }
}
