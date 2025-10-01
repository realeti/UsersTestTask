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
    
    // MARK: - Public Properties
    var isLoading = false
    var name = ""
    var email = ""
    var phone = ""
    var position = 0
    
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
            print("Not validate")
            return
        }
        
        do {
            isLoading = true
            
            let user = UserRegisterRequest(
                name: name,
                email: email,
                phone: phone,
                positionId: position,
                photo: ""
            )
            let result = try await networkService.register(user: user)
            print(result)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Validation
private extension SignUpViewModel {
    func validate() -> Bool {
        let nameResult = Result { try validationService.validate(name: name) }
        let emailResult = Result { try validationService.validate(email: email) }
        let phoneResult = Result { try validationService.validate(phone: phone) }
        
        if case .failure(let error as ValidationError) = nameResult {
            nameError = error.description
        }
        
        if case .failure(let error as ValidationError) = emailResult {
            emailError = error.description
        }
        
        if case .failure(let error as ValidationError) = phoneResult {
            phoneError = error.description
        }
        
        return nameResult.isSucess && emailResult.isSucess && phoneResult.isSucess
    }
}
