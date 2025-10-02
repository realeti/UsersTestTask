//
//  User.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import Foundation

struct User: Identifiable, Comparable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let positionId: Int
    let registrationTimestamp: Double
    let photo: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.registrationTimestamp < rhs.registrationTimestamp
    }
    
    private let phoneMask = "+XXX (XX) XXX XX XX"
    
    var formattedPhone: String {
        let cleanNumber = phone.filter(\.isWholeNumber)
        var result = ""
        var index = cleanNumber.startIndex
        
        for ch in phoneMask where index < cleanNumber.endIndex {
            if ch == "X" {
                result.append(cleanNumber[index])
                index = cleanNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
}

extension User {
    init(dto: UserDTO) {
        self.id = dto.id
        self.name = dto.name
        self.email = dto.email
        self.phone = dto.phone
        self.position = dto.position
        self.positionId = dto.positionId
        self.registrationTimestamp = dto.registrationTimestamp
        self.photo = dto.photo
    }
}
