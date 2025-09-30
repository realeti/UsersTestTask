//
//  UserTextField.swift
//  UsersTestTask
//
//  Created by realeti on 30.09.2025.
//

import SwiftUI

struct UserTextField: View {
    let title: String
    @Binding var text: String
    let isError: Bool
    let supportText: String

    @FocusState private var isFocused: Bool
    
    private var borderColor: Color {
        if isError {
            return .primaryRed
        } else if isFocused {
            return .blueSky
        } else {
            return .black.opacity(0.48)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(title, text: $text)
                .font(CustomFont.nunitoSansRegular.set(size: 16))
                .foregroundStyle(isError ? .primaryRed : .black.opacity(0.48))
                .textFieldStyle(.plain)
                .focused($isFocused)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .frame(height: 56)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(borderColor)
                }
            
            Text(supportText)
                .font(CustomFont.nunitoSansRegular.set(size: 12))
                .foregroundStyle(isError ? .primaryRed : .black.opacity(0.6))
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    UserTextField(
        title: "Phone",
        text: $text,
        isError: false,
        supportText: "+38 (XXX) XXX - XX - XX"
    )
    .padding()
}
