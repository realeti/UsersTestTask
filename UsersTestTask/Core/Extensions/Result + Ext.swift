//
//  Result + Ext.swift
//  UsersTestTask
//
//  Created by realeti on 30.09.2025.
//

import Foundation

extension Result {
    var isSucess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}
