//
//  NetError.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

enum NetError: Error {
    case statusCode(Int, Data)
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
}

extension NetError {
    var description: String {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .invalidData:
            "Invalid Data"
        case .badResponse:
            "Bad response"
        case .wrongDecode:
            "Wrong Decode"
        case .connectionProblem:
            "Connection Problem"
        case .unsupportedMessage:
            "Unsupported message"
        case .connectionNotOpen:
            "Connection not open"
        case .reconnectLimitExceeded:
            "Reconnect limit exceeded"
        case .retryFailed:
            "Retry failed"
        case .noInternet:
            "No internet"
        default:
            "Something went wrong"
        }
    }
}
