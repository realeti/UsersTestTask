//
//  UploadPhotoView.swift
//  UsersTestTask
//
//  Created by realeti on 01.10.2025.
//

import SwiftUI

struct UploadPhotoView: View {
    let isError: Bool
    let supportText: String
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .trailing) {
                ZStack(alignment: .leading) {
                    Text("Upload your photo")
                        .font(CustomFont.nunitoSansRegular.set(size: 16))
                        .foregroundStyle(isError ? .primaryRed : .black.opacity(0.6))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                    
                    TextField("", text: .constant(""))
                        .textFieldStyle(UserTextFieldStyle(isError: isError))
                        .disabled(true)
                }
                
                Button {
                    action()
                } label: {
                    Text("Upload")
                        .font(CustomFont.nunitoSansSemiBold.set(size: 16))
                        .foregroundStyle(.secondaryBlue)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
            }
            
            Text(supportText)
                .font(CustomFont.nunitoSansRegular.set(size: 12))
                .foregroundStyle(isError ? .primaryRed : .black.opacity(0.6))
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    UploadPhotoView(
        isError: false,
        supportText: "test"
    ) {}
        .padding()
}
