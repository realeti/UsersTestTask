//
//  AppDependency.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

class AppDependency {
    let network: NetworkServiceProtocol
    let validation: ValidationServiceProtocol
    
    init() {
        self.network = NetworkService()
        self.validation = ValidationService()
    }
}
