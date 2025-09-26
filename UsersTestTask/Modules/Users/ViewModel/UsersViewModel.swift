//
//  UsersViewModel.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

@Observable
final class UsersViewModel {
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol
    private(set) var users: [User] = []
    
    // MARK: - Public Properties
    var isLoading = false
    
    // MARK: - Init
    init(network: NetworkServiceProtocol) {
        self.networkService = network
    }
    
    // MARK: - Get Users
    @MainActor
    func getUsers() async {
        defer { isLoading = false }
        
        do {
            isLoading = true
            
            users = try await networkService.getUsers()
            print("Users loaded!")
        } catch let error as NetError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
    }
}
