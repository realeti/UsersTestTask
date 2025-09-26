//
//  UsersView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct UsersView: View {
    @State private var viewModel = UsersViewModel()
    
    var body: some View {
        VStack {
            TitleView(title: "Working with GET request")
            
            if !viewModel.users.isEmpty {
                UsersListView()
                    .environment(viewModel)
            } else {
                EmptyUsersView()
            }
        }
    }
}

#Preview {
    UsersView()
}
