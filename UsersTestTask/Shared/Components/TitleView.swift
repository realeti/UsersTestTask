//
//  TitleView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct TitleView: View {
    let title: String
    
    var body: some View {
        ZStack {
            Color.yellowLand
            
            Text(title)
                .font(CustomFont.nunitoSansRegular.set(size: 20))
        }
        .frame(height: 56)
    }
}

#Preview {
    TitleView(title: "Working with GET request")
}
