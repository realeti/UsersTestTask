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
}
