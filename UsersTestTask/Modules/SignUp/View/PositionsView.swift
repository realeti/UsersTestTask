//
//  PositionsView.swift
//  UsersTestTask
//
//  Created by realeti on 28.09.2025.
//

import SwiftUI

struct PositionsView: View {
    @Environment(SignUpViewModel.self) private var viewModel
    @State private var selection = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Select your position")
                .font(CustomFont.nunitoSansRegular.set(size: 18))
                .foregroundStyle(.black.opacity(0.87))
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.positions) { position in
                    RadioButton(
                        title: position.name,
                        isSelected: selection == position.id,
                        action: { selection = position.id }
                    )
                }
            }
            .padding(.leading, 17)
        }
    }
}

#Preview {
    PositionsView()
        .environment(SignUpViewModel(network: NetworkService()))
}
