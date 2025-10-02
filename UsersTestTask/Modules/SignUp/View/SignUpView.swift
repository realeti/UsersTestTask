//
//  SignUpView.swift
//  UsersTestTask
//
//  Created by realeti on 28.09.2025.
//

import SwiftUI

enum FocusField {
    case name, email, phone
}

struct SignUpView: View {
    @Environment(SignUpViewModel.self) private var viewModel
    @FocusState private var focusField: FocusField?
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        VStack(spacing: 0) {
            TitleView(title: "Working with POST request")
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 12) {
                        UserTextFieldView(
                            title: "Your name",
                            text: $viewModel.name,
                            focusField: $focusField,
                            focusFieldType: .name,
                            isError: viewModel.nameError != nil,
                            supportText: viewModel.nameError ?? ""
                        )
                        
                        UserTextFieldView(
                            title: "Email",
                            text: $viewModel.email,
                            focusField: $focusField,
                            focusFieldType: .email,
                            isError: viewModel.emailError != nil,
                            supportText: viewModel.emailError ?? ""
                        )
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        
                        UserTextFieldView(
                            title: "Phone",
                            text: $viewModel.phone,
                            focusField: $focusField,
                            focusFieldType: .phone,
                            isError: viewModel.phoneError != nil,
                            supportText: viewModel.phoneError ?? "+38 (XXX) XXX - XX - XX"
                        )
                        .keyboardType(.phonePad)
                    }
                    
                    PositionsView(
                        selection: $viewModel.position,
                        positions: viewModel.positions
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 4)
                    
                    UploadPhotoView(
                        selectedImageData: $viewModel.selectedImageData,
                        isError: viewModel.photoError != nil,
                        supportText: viewModel.photoError ?? ""
                    )
                    
                    ActionButton(
                        title: "Sign up",
                        isDisabled: false,
                        action: {
                            Task {
                                await viewModel.register()
                            }
                        }
                    )
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 32)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .fullScreenCover(isPresented: $viewModel.isRegisterProccessed, onDismiss: {
            viewModel.isRegisterProccessed = false
        }, content: {
            EventView(
                title: viewModel.registerMessage,
                image: viewModel.isRegisterSuccess ? "RegisterSuccess" : "RegisterFailed",
                buttonTitle: viewModel.isRegisterSuccess ? "Got it" : "Try again",
                isLoading: false,
                isCanDismiss: true
            ) { viewModel.isRegisterSuccess = false }
        })
        .task {
            await viewModel.getUserPositions()
        }
        .contentShape(Rectangle())
        .onTapGesture { focusField = nil }
    }
}

#Preview {
    SignUpView()
        .environment(SignUpViewModel(
            network: NetworkService(),
            validation: ValidationService())
        )
}
