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
    var currentPage = 1
    var totalUsers = 0
    
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
            
            let newUsers = try await networkService.getUsers(page: currentPage)
            users.append(contentsOf: newUsers)
            users.sort(by: { $0.registrationTimestamp > $1.registrationTimestamp })
            print(users)
        } catch let error as NetError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
    }
}
