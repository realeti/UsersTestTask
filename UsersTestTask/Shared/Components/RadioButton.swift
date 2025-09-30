//
//  RadioButton.swift
//  UsersTestTask
//
//  Created by realeti on 29.09.2025.
//

import SwiftUI

struct RadioButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 24) {
            Button {
                action()
            } label: {
                Image(systemName: isSelected ? "circle.inset.filled" : "circle")
                    .resizable()
                    .foregroundColor(.blueSky)
                    .frame(width: 14, height: 14)
            }
            //.symbolEffect(.bounce, options: .speed(3), value: isSelected)
            
            Text(title)
                .font(CustomFont.nunitoSansRegular.set(size: 16))
                .foregroundColor(.black.opacity(0.87))
        }
    }
}

#Preview {
    RadioButton(title: "Title", isSelected: false) {}
}
