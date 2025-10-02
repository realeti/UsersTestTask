//
//  UploadPhotoView.swift
//  UsersTestTask
//
//  Created by realeti on 01.10.2025.
//

import SwiftUI
import PhotosUI

struct UploadPhotoView: View {
    @State private var selectedItem: PhotosPickerItem?
    @Binding var selectedImageData: Data?
    
    let isError: Bool
    let supportText: String
    
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
                        .textFieldStyle(
                            UserTextFieldStyle(
                                isError: isError,
                                isFocused: false)
                        )
                        .disabled(true)
                }
                
                PhotosPicker("Upload", selection: $selectedItem, matching: .images)
                    .onChange(of: selectedItem) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                
                /*Button {
                    action()
                } label: {
                    /*Text("Upload")
                        .font(CustomFont.nunitoSansSemiBold.set(size: 16))
                        .foregroundStyle(.secondaryBlue)*/
                    /*PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("Upload")
                            .font(CustomFont.nunitoSansSemiBold.set(size: 16))
                            .foregroundStyle(.secondaryBlue)
                    }*/
                }*/
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
        selectedImageData: .constant(Data()),
        isError: false,
        supportText: "test"
    )
    .padding()
}
