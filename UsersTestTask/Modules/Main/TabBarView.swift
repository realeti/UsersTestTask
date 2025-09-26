//
//  TabBarView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct TabBarView: View {
    enum TabItem: String {
        case users
        case signUp
        case search
    }

    @State private var selection: TabItem = .users
    @State private var search = ""

    var body: some View {
        TabView(selection: $selection) {
            Tab(value: .users) {
                Text("Users view")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .toolbarBackground(.red, for: .tabBar)
            } label: {
                Label {
                    Text("Users")
                } icon: {
                    Image(.usersIcon)
                        .foregroundStyle(selection == .users ? .blueSky : .black.opacity(0.6))
                }
                // .environment(\.symbolVariants, .none)
            }

            Tab(value: .signUp) {
                Text("Sign up view")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .toolbarBackground(.red, for: .tabBar)
            } label: {
                Label {
                    Text("Sign up")
                } icon: {
                    Image(.signUpIcon)
                        .foregroundStyle(selection == .signUp ? .blueSky : .black.opacity(0.6))
                }
                // .environment(\.symbolVariants, .none)
            }

            /*Tab(value: .search, role: .search) {
                NavigationStack {
                    Text("Search view")
                }
            }*/
        }
        //.searchable(text: $search)
        .tint(Color(.blueSky))
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    TabBarView()
}
