//
//  ValidationService.swift
//  UsersTestTask
//
//  Created by realeti on 30.09.2025.
//

import Foundation

protocol ValidationServiceProtocol {
    func validate(name: String) throws
    func validate(email: String) throws
    func validate(phone: String) throws
    func validate(photo: Data) throws
}

final class ValidationService: ValidationServiceProtocol {
    func validate(name: String) throws {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if name.count < 2 || name.count > 60 {
            throw ValidationError.invalidName
        }
    }
    
    func validate(email: String) throws {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !predicate.evaluate(with: email) {
            throw ValidationError.invalidEmail
        }
    }
    
    func validate(phone: String) throws {
        let phone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneRegex = #"^\+380\d{9}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        if !predicate.evaluate(with: phone) {
            throw ValidationError.invalidPhoneNumber
        }
    }
    
    func validate(photo: Data) throws {
        
    }
}
