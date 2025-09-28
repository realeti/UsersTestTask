//
//  ConnectionProblemView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct EventView: View {
    let title: String
    let image: String
    let buttonTitle: String
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image(image)
                .resizable()
                .frame(width: 200, height: 200)
            
            Text(title)
                .font(CustomFont.nunitoSansRegular.set(size: 20))
                .foregroundStyle(.black.opacity(0.87))
            
            ActionButton(title: buttonTitle, isDisabled: isLoading, action: action)
        }
    }
}

#Preview {
    //NoConnection
    //RegisterSuccess
    //RegisterFailed
    
    EventView(
        title: "There is no internet connection",
        image: "NoConnection",
        buttonTitle: "Try again",
        isLoading: false
    ) {}
}
