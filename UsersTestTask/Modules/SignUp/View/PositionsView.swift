//
//  PositionsView.swift
//  UsersTestTask
//
//  Created by realeti on 28.09.2025.
//

import SwiftUI

struct PositionsView: View {
    @Binding var selection: Int
    var positions: [UserPosition]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Select your position")
                .font(CustomFont.nunitoSansRegular.set(size: 18))
                .foregroundStyle(.black.opacity(0.87))
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(positions) { position in
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
    @Previewable @State var selection = 0
    
    PositionsView(
        selection: $selection,
        positions: [
            UserPosition(id: 1, name: "Testy"),
            UserPosition(id: 2, name: "Testy2")
        ]
    )
}
