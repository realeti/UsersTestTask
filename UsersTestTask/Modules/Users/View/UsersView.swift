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
        VStack {
            TitleView(title: "Working with GET request")
            
            if !viewModel.users.isEmpty {
                UsersListView()
            } else {
                EmptyUsersView()
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
