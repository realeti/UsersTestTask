//
//  EmptyUsersView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct EmptyUsersView: View {
    var body: some View {
        ContentUnavailableView {
            VStack(spacing: 24) {
                Image(.users)
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Text("There are no users yet")
                    .font(CustomFont.nunitoSansRegular.set(size: 24))
                    .foregroundStyle(.black.opacity(0.87))
            }
        }
    }
}

#Preview {
    EmptyUsersView()
}
