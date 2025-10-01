//
//  SignUpView.swift
//  UsersTestTask
//
//  Created by realeti on 28.09.2025.
//

import SwiftUI

struct SignUpView: View {
    @Environment(SignUpViewModel.self) private var viewModel
    
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
                            isError: viewModel.nameError != nil,
                            supportText: viewModel.nameError ?? ""
                        )
                        
                        UserTextFieldView(
                            title: "Email",
                            text: $viewModel.email,
                            isError: viewModel.emailError != nil,
                            supportText: viewModel.emailError ?? ""
                        )
                        .keyboardType(.emailAddress)
                        
                        UserTextFieldView(
                            title: "Phone",
                            text: $viewModel.phone,
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
                        isError: viewModel.photoError != nil,
                        supportText: viewModel.photoError ?? "",
                        action: {}
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
        }
        .task {
            await viewModel.getUserPositions()
        }
    }
}

#Preview {
    SignUpView()
        .environment(SignUpViewModel(
            network: NetworkService(),
            validation: ValidationService())
        )
}
