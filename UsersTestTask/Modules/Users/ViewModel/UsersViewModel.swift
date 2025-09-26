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
    
    // MARK: - Init
    init(network: NetworkServiceProtocol) {
        self.networkService = network
    }
    
    // MARK: - Get Users
    func getUsers() async {
        do {
            users = try await networkService.getUsers()
            print("Users loaded!")
        } catch let error as NetError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
    }
}
