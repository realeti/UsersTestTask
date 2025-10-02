//
//  Data + Ext.swift
//  UsersTestTask
//
//  Created by realeti on 30.09.2025.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
