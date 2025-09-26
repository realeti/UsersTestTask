//
//  ConnectionProblemView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct ConnectionProblemView: View {
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image(.noConnection)
                .resizable()
                .frame(width: 200, height: 200)
            
            Text("There is no internet connection")
                .font(CustomFont.nunitoSansRegular.set(size: 20))
                .foregroundStyle(.black.opacity(0.87))
            
            Button {
                print("Click")
                action()
            } label: {
                Text("Try again")
                    .font(CustomFont.nunitoSansSemiBold.set(size: 18))
                    .foregroundStyle(.black.opacity(0.87))
                    .padding(EdgeInsets(top: 12, leading: 31.5, bottom: 12, trailing: 31.5))
                    .background(.yellowLand)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
        }
    }
}

#Preview {
    ConnectionProblemView {}
}
