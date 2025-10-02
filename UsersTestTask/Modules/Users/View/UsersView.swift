//
//  UsersView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct UsersView: View {
    @Environment(UsersViewModel.self) private var viewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.notConnectedToInternet {
                ZStack(alignment: .bottom) {
                    EventView(
                        title: "There is no internet connection",
                        image: "NoConnection",
                        buttonTitle: "Try again",
                        isLoading: viewModel.isLoading,
                        isCanDismiss: false,
                        action: {
                            Task {
                                await viewModel.getUsers()
                            }
                        }
                    )
                    .toolbarVisibility(.hidden, for: .tabBar)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .controlSize(.regular)
                            .offset(y: 32)
                    }
                }
            } else if viewModel.users.isEmpty && !viewModel.isLoading {
                EmptyUsersView()
            } else {
                TitleView(title: "Working with GET request")
                UsersListView()
            }
        }
        .task {
            await viewModel.getUsers()
        }
    }
}

#Preview {
    UsersView()
}
