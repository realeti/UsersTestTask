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
        VStack(spacing: 0) {
            TitleView(title: "Working with POST request")
            
            Spacer()
            
            VStack(spacing: 0) {
                ActionButton(
                    title: "Sign up",
                    isDisabled: false,
                    action: {}
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 32)
        }
    }
}

#Preview {
    SignUpView()
        .environment(SignUpViewModel(network: NetworkService()))
}
