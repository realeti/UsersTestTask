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
                    VStack(spacing: 16) {
                        UserTextField(
                            title: "Your name",
                            text: $viewModel.name,
                            isError: false,
                            supportText: ""
                        )
                        
                        UserTextField(
                            title: "Email",
                            text: $viewModel.email,
                            isError: false,
                            supportText: ""
                        )
                        
                        UserTextField(
                            title: "Phone",
                            text: $viewModel.name,
                            isError: false,
                            supportText: "+38 (XXX) XXX - XX - XX"
                        )
                    }
                    
                    PositionsView(
                        selection: $viewModel.position,
                        positions: viewModel.positions
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    UserTextField(
                        title: "Upload your photo",
                        text: $viewModel.name,
                        isError: false,
                        supportText: ""
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
