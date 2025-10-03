//
//  ValidationService.swift
//  UsersTestTask
//
//  Created by realeti on 30.09.2025.
//

import UIKit

protocol ValidationServiceProtocol {
    func validate(name: String) throws
    func validate(email: String) throws
    func validate(phone: String) throws
    func validate(photo: Data?) throws
}

final class ValidationService: ValidationServiceProtocol {
    func validate(name: String) throws {
        if name.isEmpty {
            throw ValidationError.empty
        }
        
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if name.count < 2 || name.count > 60 {
            throw ValidationError.invalidName
        }
    }
    
    func validate(email: String) throws {
        if email.isEmpty {
            throw ValidationError.empty
        }
        
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !predicate.evaluate(with: email) {
            throw ValidationError.invalidEmail
        }
    }
    
    func validate(phone: String) throws {
        if phone.isEmpty {
            throw ValidationError.empty
        }
        
        let phone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneRegex = #"^\+380\d{9}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        if !predicate.evaluate(with: phone) {
            throw ValidationError.invalidPhoneNumber
        }
    }
    
    func validate(photo: Data?) throws {
        // Data is not empty
        guard let photo, !photo.isEmpty else {
            throw ValidationError.emptyPhoto
        }
        
        // Photo format
        guard let mimeType = detectMimeType(photo),
              ["image/jpeg", "image/png"].contains(mimeType) else {
            throw ValidationError.unsupportedFormat
        }
        
        // Photo size <= 5 MB
        let maxSize = 5 * 1024 * 1024
        
        if photo.count > maxSize {
            throw ValidationError.photoTooLarge
        }
        
        // Photo size >= 70px
        if let image = UIImage(data: photo) {
            if image.size.width < 70 || image.size.height < 70 {
                throw ValidationError.photoToSmall
            }
        } else {
            throw ValidationError.invalidImage
        }
    }
}

private extension ValidationService {
    func detectMimeType(_ data: Data) -> String? {
        let bytes = [UInt8](data.prefix(8))
        if bytes.starts(with: [0xFF, 0xD8, 0xFF]) { return "image/jpeg" }
        if bytes.starts(with: [0x89, 0x50, 0x4E, 0x47]) { return "image/png" }
        return nil
    }
}
