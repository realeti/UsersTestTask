//
//  UserTextFieldView.swift
//  UsersTestTask
//
//  Created by realeti on 30.09.2025.
//

import SwiftUI

struct UserTextFieldView: View {
    let title: String
    @Binding var text: String
    let isError: Bool
    let supportText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(title)
                        .font(CustomFont.nunitoSansRegular.set(size: 16))
                        .foregroundStyle(isError ? .primaryRed : .black.opacity(0.6))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                }
                
                TextField("", text: $text)
                    .textFieldStyle(UserTextFieldStyle(isError: isError))
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
    UserTextFieldView(
        title: "Phone",
        text: $text,
        isError: false,
        supportText: "+38 (XXX) XXX - XX - XX"
    )
    .padding()
}
