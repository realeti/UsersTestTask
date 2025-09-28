//
//  ActionButton.swift
//  UsersTestTask
//
//  Created by realeti on 27.09.2025.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    var isDisabled = false
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
        }
        .buttonStyle(ActionButtonStyle(isDisabled: isDisabled))
        .disabled(isDisabled)
    }
}

#Preview {
    ActionButton(title: "Try again", action: {})
}

struct ActionButtonStyle: ButtonStyle {
    let isDisabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        var buttonColor: Color {
            if isDisabled {
                .primaryGray
            } else if !configuration.isPressed {
                .yellowLand
            } else {
                .lightOrange
            }
        }
        
        configuration.label
            .font(CustomFont.nunitoSansSemiBold.set(size: 18))
            .foregroundStyle(.black.opacity(0.87))
            .padding(EdgeInsets(top: 12, leading: 31.5, bottom: 12, trailing: 31.5))
            .background(buttonColor)
            .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
