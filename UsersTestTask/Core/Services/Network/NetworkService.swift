//
//  NetworkService.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getUsers(page: Int) async throws -> [User]
    func register(user: User) async throws -> Bool
}

final class NetworkService: NetworkServiceProtocol {
    private let session = URLSession.shared
    private lazy var decoder = JSONDecoder()
    
    // MARK: - Base URL Components
    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = AppConfig.apiHost
        return components
    }
}

// MARK: - Perform Request
private extension NetworkService {
    func performRequest(request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetError.badResponse
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetError.statusCode(httpResponse.statusCode)
            }
            
            return data
        } catch {
            throw NetError.reconnectLimitExceeded
        }
    }
}

// MARK: - Get Users
extension NetworkService {
    func getUsers(page: Int) async throws -> [User] {
        var components = baseUrlComponents
        components.path = APIEndpoint.users
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "count", value: "6"),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let data = try await performRequest(request: request)
        
        do {
            let decodedData = try decoder.decode(UsersResponseDTO.self, from: data)
            return decodedData.users.map { User(dto: $0) }
        } catch {
            throw NetError.wrongDecode
        }
    }
}

// MARK: - Register User
extension NetworkService {
    func register(user: User) async throws -> Bool {
        return true
    }
}
