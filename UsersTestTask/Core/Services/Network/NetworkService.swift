//
//  NetworkService.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getUsers(page: Int) async throws -> UsersResponseDTO
    func register(user: UserRegisterRequest) async throws -> Bool
    func getUserPositions() async throws -> [UserPosition]
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
        } catch let error as URLError {
            if error.code == .notConnectedToInternet || error.code == .networkConnectionLost || error.code == .timedOut {
                throw NetError.noInternet
            }
            print("URLError:", error.localizedDescription)
            throw NetError.reconnectLimitExceeded
        } catch {
            throw NetError.connectionProblem
        }
    }
}

// MARK: - Get Users
extension NetworkService {
    func getUsers(page: Int) async throws -> UsersResponseDTO {
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
        request.timeoutInterval = 10
        
        let data = try await performRequest(request: request)
        
        do {
            return try decoder.decode(UsersResponseDTO.self, from: data)
        } catch {
            throw NetError.wrongDecode
        }
    }
}

// MARK: - Register User
extension NetworkService {
    func register(user: UserRegisterRequest) async throws -> Bool {
        var components = baseUrlComponents
        components.path = APIEndpoint.users
        
        guard let url = components.url else {
            throw NetError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.timeoutInterval = 10
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = getBoundaryBody(for: user, boundary)
        
        let data = try await performRequest(request: request)
        
        do {
            let decodedData = try decoder.decode(UserRegisterDTO.self, from: data)
            print("USER REGISTATION RESULT:")
            print(decodedData.message)
            print(decodedData.fails.name ?? "No name error")
            print(decodedData.fails.email ?? "No email error")
            print(decodedData.fails.phone ?? "No phone error")
            print(decodedData.fails.positionId ?? "No position_id error")
            print(decodedData.fails.photo ?? "No photo error")
            return decodedData.success
        } catch {
            throw NetError.wrongDecode
        }
    }
}

// MARK: - Generate Body for Register User
private extension NetworkService {
    func getBoundaryBody(for user: UserRegisterRequest, _ boundary: String) -> Data {
        var body = Data()
        
        let fieldName = "name"
        let fieldNameValue = user.name
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n\r\n")
        body.append("\(fieldNameValue)\r\n")
        
        let fieldEmail = "email"
        let fieldEmailValue = user.email
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(fieldEmail)\"\r\n\r\n")
        body.append("\(fieldEmailValue)\r\n")
        
        let fieldPhone = "phone"
        let fieldPhoneValue = user.phone
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(fieldPhone)\"\r\n\r\n")
        body.append("\(fieldPhoneValue)\r\n")
        
        let fieldPosition = "position_id"
        let fieldPositionValue = user.positionId
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(fieldPosition)\"\r\n\r\n")
        body.append("\(fieldPositionValue)\r\n")
        
        let fieldPhoto = "photo"
        let fieldPhotoValue = user.photo
        let mimeType = "image/jpeg"
        let photoData = Data()
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(fieldPhoto)\"; filename=\"\(fieldPhotoValue)\"\r\n")
        body.append("Content-Type: \(mimeType)\r\n\r\n")
        body.append(photoData)
        body.append("\r\n")
        
        body.append("--\(boundary)--\r\n")
        
        return body
    }
}

// MARK: - Get User Positions
extension NetworkService {
    func getUserPositions() async throws -> [UserPosition] {
        var components = baseUrlComponents
        components.path = APIEndpoint.positions
        
        guard let url = components.url else {
            throw NetError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 10
        
        let data = try await performRequest(request: request)
        
        do {
            let decodedData = try decoder.decode(UserPositionsDTO.self, from: data)
            return decodedData.positions.map { UserPosition(dto: $0) }
        } catch {
            throw NetError.wrongDecode
        }
    }
}
