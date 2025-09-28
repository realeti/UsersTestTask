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
    
    // MARK: - Init
    init(network: NetworkServiceProtocol) {
        self.networkService = network
    }
}
