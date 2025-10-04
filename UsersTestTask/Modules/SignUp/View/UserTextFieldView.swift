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
    var isPhoneField = false
    
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
                    .onChange(of: text) { _, newValue in
                        if isPhoneField {
                            applyMask(for: newValue)
                        }
                    }
            }
            
            Text(supportText)
                .font(CustomFont.nunitoSansRegular.set(size: 12))
                .foregroundStyle(isError ? .primaryRed : .black.opacity(0.6))
                .padding(.horizontal, 16)
        }
    }
}

private extension UserTextFieldView {
    func applyMask(for newValue: String) {
        let mask = "+XX (XXX) XXX - XX - XX"
        let maxDigits = 12
        let digits = newValue.filter(\.isWholeNumber)
        var trimmedText = String(digits.prefix(maxDigits))
        
        var result = ""
        
        for char in mask {
            guard !trimmedText.isEmpty else { break }
            
            if char == "X" {
                result.append(trimmedText.removeFirst())
            } else {
                result.append(char)
            }
        }
        
        if result != newValue {
            text = result
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
