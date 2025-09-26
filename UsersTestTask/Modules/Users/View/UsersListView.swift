//
//  UsersListView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct UsersListView: View {
    @Environment(UsersViewModel.self) private var viewModel
    
    var body: some View {
        List(viewModel.users) { user in
            Text(user.name)
        }
    }
}

#Preview {
    UsersListView()
        .environment(UsersViewModel())
}
