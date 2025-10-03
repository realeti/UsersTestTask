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
    case invalidImage
    case unsupportedFormat
    case emptyPhoto
    case photoTooLarge
    case photoToSmall
    case empty
    
    var description: String {
        switch self {
        case .invalidName:
            "Invalid name format"
        case .invalidEmail:
            "Invalid email format"
        case .invalidPhoneNumber:
            "Invalid phone format"
        case .invalidImage:
            "Invalid image"
        case .unsupportedFormat:
            "Unsupported image format"
        case .emptyPhoto:
            "Photo is required"
        case .photoTooLarge:
            "Photo is too large"
        case .photoToSmall:
            "Photo is too small"
        case .empty:
            "Required field"
        }
    }
}
