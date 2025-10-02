//
//  ConnectionProblemView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

struct EventView: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    let image: String
    let buttonTitle: String
    let isLoading: Bool
    let isCanDismiss: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Image(image)
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Text(title)
                    .font(CustomFont.nunitoSansRegular.set(size: 20))
                    .foregroundStyle(.black.opacity(0.87))
                
                ActionButton(title: buttonTitle, isDisabled: isLoading, action: action)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if isCanDismiss {
                Button {
                    dismiss()
                } label: {
                    VStack {
                        Image(.close)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, 24)
                            .padding(.trailing, 24)
                        
                        Spacer()
                    }
                }
            }
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
            isLoading: false,
            isCanDismiss: true
        ) {}
    }
