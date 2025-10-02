//
//  UploadPhotoView.swift
//  UsersTestTask
//
//  Created by realeti on 01.10.2025.
//

import SwiftUI

struct UploadPhotoView: View {
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @Binding var selectedImageData: Data?
    
    let isError: Bool
    let supportText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .trailing) {
                ZStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("Upload your photo")
                            .font(CustomFont.nunitoSansRegular.set(size: 16))
                            .foregroundStyle(isError ? .primaryRed : .black.opacity(0.6))
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.green)
                            .padding(.leading, -8)
                            .opacity(selectedImage == nil ? 0 : 1)
                    }
                    
                    TextField("", text: .constant(""))
                        .textFieldStyle(
                            UserTextFieldStyle(
                                isError: isError,
                                isFocused: false)
                        )
                        .disabled(true)
                }
                
                Button {
                    showActionSheet = true
                } label: {
                    Text("Upload")
                        .font(CustomFont.nunitoSansSemiBold.set(size: 16))
                        .foregroundStyle(.secondaryBlue)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .confirmationDialog(
                    "Choose how you want to add a photo",
                    isPresented: $showActionSheet,
                    titleVisibility: .visible
                ) {
                    Button("Camera") {
                        sourceType = .camera
                        showImagePicker = true
                    }
                    
                    Button("Gallery") {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    }
                    
                    Button("Cancel", role: .cancel) { }
                }
                .fullScreenCover(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
                        .ignoresSafeArea()
                }
            }
            
            Text(supportText)
                .font(CustomFont.nunitoSansRegular.set(size: 12))
                .foregroundStyle(isError ? .primaryRed : .black.opacity(0.6))
                .padding(.horizontal, 16)
                .padding(.bottom, 6)
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
                    .shadow(color: .black.opacity(0.15), radius: 4)
                    .frame(height: 250)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .onChange(of: selectedImage) { _, newImage in
            if let newImage {
                selectedImageData = newImage.jpegData(compressionQuality: 0.7)
            }
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
