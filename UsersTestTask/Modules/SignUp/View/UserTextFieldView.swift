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
    var focusField: FocusState<FocusField?>.Binding
    let focusFieldType: FocusField
    let isError: Bool
    let supportText: String
    
    @FocusState private var isFocused: Bool
    
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
                    .textFieldStyle(UserTextFieldStyle(
                        isError: isError,
                        isFocused: focusField.wrappedValue == focusFieldType)
                    )
                    .focused(focusField, equals: focusFieldType)
            }
            
            Text(supportText)
                .font(CustomFont.nunitoSansRegular.set(size: 12))
                .foregroundStyle(isError ? .primaryRed : .black.opacity(0.6))
                .padding(.horizontal, 16)
        }
    }
}

/*#Preview {
    @Previewable @State var text = ""
    @Previewable @FocusState var focusField: FocusField?
    
    UserTextFieldView(
        title: "Phone",
        text: $text,
        focusField: $focusField,
        focusFieldType: .phone,
        isError: false,
        supportText: "+38 (XXX) XXX - XX - XX"
    )
    .padding()
}*/
