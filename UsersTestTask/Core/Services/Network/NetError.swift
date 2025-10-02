//
//  NetError.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

enum NetError: Error {
    case statusCode(Int)
    case invalidURL
    case invalidData
    case badResponse
    case wrongDecode
    case connectionProblem
    case connectionNotOpen
    case unsupportedMessage
    case reconnectLimitExceeded
    case retryFailed
    case noInternet
    
    var description: String {
        if case .statusCode(let code) = self {
            switch code {
            case 409:
                return "User with this phone or email already exist"
            case 401:
                return "The token expired."
            case 422:
                return "Validation failed"
            default:
                return "Unknown status code: \(code)"
            }
        }
        
        return "Unknown error"
    }
}
