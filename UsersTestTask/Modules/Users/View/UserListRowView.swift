//
//  UserListRowView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct UserListRowView: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: user.photo)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            .clipped()
            .transition(.opacity)
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(CustomFont.nunitoSansRegular.set(size: 18))
                        .foregroundStyle(.black.opacity(0.87))
                    
                    Text(user.position)
                        .font(CustomFont.nunitoSansRegular.set(size: 14))
                        .foregroundStyle(.black.opacity(0.6))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.email)
                    Text(user.phone)
                }
                .font(CustomFont.nunitoSansRegular.set(size: 14))
                .foregroundStyle(.black.opacity(0.87))
                
                Spacer()
                    .frame(height: 24)
            }
        }
    }
}

#Preview {
    UserListRowView(user: User(
        id: 1,
        name: "Leanne West",
        email: "onie34@lubowitz.com",
        phone: "+380936050764",
        position: "Content manager",
        positionId: 2,
        registrationTimestamp: 1604494937,
        photo: "https://frontend-test-assignment-api.abz.agency/images/users/5fa2a6596d3bb1.jpeg")
    )
}
