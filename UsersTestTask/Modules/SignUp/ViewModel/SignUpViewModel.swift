//
//  SignUpViewModel.swift
//  UsersTestTask
//
//  Created by realeti on 28.09.2025.
//

import SwiftUI

@Observable
final class SignUpViewModel {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol
    private let validationService: ValidationServiceProtocol
    private(set) var positions: [UserPosition] = []
    private var phoneDigits = ""
    
    // MARK: - Public Properties
    var isLoading = false
    var name = ""
    var email = ""
    var phone = "" {
        didSet {
            phoneDigits = "+\(phone.filter(\.isWholeNumber))"
        }
    }
    var position = 0
    var selectedImageData: Data?
    
    var isRegisterSuccess = false
    var registerMessage = ""
    var isRegisterProccessed = false
    
    var nameError: String?
    var emailError: String?
    var phoneError: String?
    var photoError: String?
    
    // MARK: - Init
    init(network: NetworkServiceProtocol, validation: ValidationServiceProtocol) {
        self.networkService = network
        self.validationService = validation
    }
}

// MARK: - Get User Positions
extension SignUpViewModel {
    func getUserPositions() async {
        defer { isLoading = false }
        
        do {
            isLoading = true
            positions = try await networkService.getUserPositions()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Register User
extension SignUpViewModel {
    func register() async {
        defer { isLoading = false }
        
        guard validate() else {
            return
        }
        
        do {
            isLoading = true
            
            let user = UserRegisterRequest(
                name: name,
                email: email,
                phone: phoneDigits,
                positionId: position,
                photoData: selectedImageData
            )
            
            let result = try await networkService.register(user: user)
            isRegisterSuccess = result.success
            registerMessage = result.message
            print(result)
        } catch let error as NetError {
            isRegisterProccessed = true
            handleNetworkError(error: error)
        } catch {
            isRegisterProccessed = true
            print(error.localizedDescription)
        }
    }
}

// MARK: - Validation
private extension SignUpViewModel {
    func validate() -> Bool {
        clearErrorMessages()
        
        let nameResult = Result { try validationService.validate(name: name) }
        let emailResult = Result { try validationService.validate(email: email) }
        let phoneResult = Result { try validationService.validate(phone: phoneDigits) }
        let photoResult = Result { try validationService.validate(photo: selectedImageData) }
        
        if case .failure(let error as ValidationError) = nameResult {
            nameError = error.description
        }
        
        if case .failure(let error as ValidationError) = emailResult {
            emailError = error.description
        }
        
        if case .failure(let error as ValidationError) = phoneResult {
            phoneError = error.description
        }
        
        if case .failure(let error as ValidationError) = photoResult {
            photoError = error.description
        }
        
        return nameResult.isSucess
        && emailResult.isSucess
        && phoneResult.isSucess
        && photoResult.isSucess
    }
    
    func clearErrorMessages() {
        nameError = nil
        emailError = nil
        phoneError = nil
        photoError = nil
    }
}

// MARK: - Handle Network Error
private extension SignUpViewModel {
    func handleNetworkError(error: NetError) {
        switch error {
        case .statusCode(_, let data):
            guard let dto = try? JSONDecoder().decode(UserRegisterDTO.self, from: data) else {
                registerMessage = error.description
                return
            }
            
        registerMessage = getFailsErrorMessage(dto: dto)
        default:
            registerMessage = error.description
        }
    }
    
    func getFailsErrorMessage(dto: UserRegisterDTO) -> String {
        if let fails = dto.fails {
            let fieldError =
                fails.name?.first ??
                fails.email?.first ??
                fails.phone?.first ??
                fails.positionId?.first ??
                fails.photo?.first
            
            if let fieldError {
                return ("\(dto.message)\n\(fieldError)")
            } else {
                return dto.message
            }
        } else {
            return dto.message
        }
    }
}
