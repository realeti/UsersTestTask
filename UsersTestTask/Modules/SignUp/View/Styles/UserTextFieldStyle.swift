//
//  UserTextFieldStyle.swift
//  UsersTestTask
//
//  Created by realeti on 01.10.2025.
//

import SwiftUI

struct UserTextFieldStyle: TextFieldStyle {
    let isError: Bool
    let isFocused: Bool
    
    private var borderColor: Color {
        if isError {
            return .primaryRed
        } else if isFocused {
            return .blueSky
        } else {
            return .black.opacity(0.48)
        }
    }
    
    // swiftlint:disable:next identifier_name
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(CustomFont.nunitoSansRegular.set(size: 16))
            .foregroundStyle(.black.opacity(0.87))
            //.focused($isFocused)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .frame(height: 56)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(borderColor)
            }
    }
}
