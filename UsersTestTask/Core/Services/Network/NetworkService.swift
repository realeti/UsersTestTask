//
//  NetworkService.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getUsers(page: Int) async throws -> UsersResponseDTO
    func register(user: UserRegisterRequest) async throws -> UserRegisterResponse
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
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await session.data(for: request)
        } catch let error as URLError {
            if error.code == .notConnectedToInternet ||
                error.code == .networkConnectionLost ||
                error.code == .timedOut {
                throw NetError.noInternet
            }
            throw NetError.connectionProblem
        } catch {
            throw NetError.connectionProblem
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Bad Response")
            throw NetError.badResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            print("Status code \(httpResponse.statusCode)")
            throw NetError.statusCode(httpResponse.statusCode, data)
        }
        
        return data
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
    func register(user: UserRegisterRequest) async throws -> UserRegisterResponse {
        var components = baseUrlComponents
        components.path = APIEndpoint.users
        
        guard let url = components.url else {
            throw NetError.invalidURL
        }
        
        let token = try await generateToken()
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.timeoutInterval = 10
        request.setValue(token, forHTTPHeaderField: "Token")
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = getBoundaryBody(for: user, boundary)
        
        let data = try await performRequest(request: request)
        
        do {
            let decodedData = try decoder.decode(UserRegisterDTO.self, from: data)
            print("USER REGISTATION RESULT:")
            print(decodedData.message)
            return UserRegisterResponse(dto: decodedData)
        } catch {
            print("Wrong decode")
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
        let fileName = "avatar.jpg"
        let mimeType = "image/jpeg"
        if let photoData = user.photoData {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(fieldPhoto)\"; filename=\"\(fileName)\"\r\n")
            body.append("Content-Type: \(mimeType)\r\n\r\n")
            body.append(photoData)
            body.append("\r\n")
        }
        
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

// MARK: - Generate token
private extension NetworkService {
    func generateToken() async throws -> String {
        var components = baseUrlComponents
        components.path = APIEndpoint.token
        
        guard let url = components.url else {
            throw NetError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 10
        
        let data = try await performRequest(request: request)
        
        do {
            return try decoder.decode(UserTokenDTO.self, from: data).token
        } catch {
            throw NetError.wrongDecode
        }
    }
}
