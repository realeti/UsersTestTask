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
    private(set) var positions: [UserPosition] = []
    
    // MARK: - Public Properties
    var isLoading = false
    
    // MARK: - Init
    init(network: NetworkServiceProtocol) {
        self.networkService = network
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
