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
        VStack(alignment: .leading, spacing: 12) {
            Text("Select your position")
                .font(CustomFont.nunitoSansRegular.set(size: 18))
                .foregroundStyle(.black.opacity(0.87))
            
            /*Picker("", selection: $selection) {
                ForEach(viewModel.positions) { position in
                    Text(position.name)
                        .tag(position.id)
                }
            }
            .pickerStyle(.inline)*/
            
            ForEach(viewModel.positions) { position in
                HStack(spacing: 24) {
                    Image(systemName: selection == position.id ? "largecircle.fill.circle" : "circle")
                        .resizable()
                        .foregroundColor(selection == position.id ? .blueSky : .blueSky)
                        .frame(width: 14, height: 14)
                    
                    Text(position.name)
                        .font(CustomFont.nunitoSansRegular.set(size: 16))
                        .foregroundColor(.black.opacity(0.87))
                }
            }
        }
    }
}

#Preview {
    PositionsView()
        .environment(SignUpViewModel(network: NetworkService()))
}
