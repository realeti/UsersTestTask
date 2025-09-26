//
//  CustomFont.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI

enum CustomFont {
    case nunitoSansRegular
    case nunitoSansSemiBold
    
    private var fontName: String {
        switch self {
        case .nunitoSansRegular:
            "NunitoSans-Regular"
        case .nunitoSansSemiBold:
            "NunitoSans-SemiBold"
        }
    }
    
    func set(size: CGFloat) -> Font {
        Font.custom(fontName, size: size)
    }
}
