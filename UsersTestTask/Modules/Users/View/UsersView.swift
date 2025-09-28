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
                ZStack(alignment: .top) {
                    EventView(
                        title: "There is no internet connection",
                        image: "NoConnection",
                        buttonTitle: "Try again",
                        isLoading: viewModel.isLoading,
                        action: {
                            Task {
                                await viewModel.getUsers()
                            }
                        }
                    )
                    .toolbarVisibility(.hidden, for: .tabBar)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
            } else if viewModel.users.isEmpty {
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
