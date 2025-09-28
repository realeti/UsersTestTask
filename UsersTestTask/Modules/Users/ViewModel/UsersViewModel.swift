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
    var notConnectedToInternet = false
    var isLoading = false
    var currentPage = 0
    var totalPages = 0
    
    // MARK: - Init
    init(network: NetworkServiceProtocol) {
        self.networkService = network
    }
}

// MARK: - Get Users
extension UsersViewModel {
    func getUsers() async {
        defer {
            isLoading = false }
        
        guard currentPage < totalPages || currentPage == 0 else {
            return
        }
        
        do {
            isLoading = true
            
            let data = try await networkService.getUsers(page: currentPage + 1)
            let newUsers = data.users.map { User(dto: $0) }
            totalPages = data.totalPages
            notConnectedToInternet = false
            
            guard !newUsers.isEmpty else {
                return
            }
            
            currentPage += 1
            users.append(contentsOf: newUsers)
            users.sort(by: >)
        } catch NetError.noInternet {
            notConnectedToInternet = true
        } catch {
            print(error.localizedDescription)
        }
    }
}
